#!/usr/bin/env bash
set -e

for var in PROJECT; do
    if [[ -z "${!var:-}" ]];
    then
        echo "You need to provide a value for env variable $var"
        exit 1
    fi
done

IMPORT_FOLDER=/var/lib/neo4j/import
TEMP_BQ_DATASET=ethereum_etl_neo4j_temp
TEMP_GCS_BUCKET=ethereum_etl_neo4j_temp_$PROJECT

function create_temp_resources {
    bq mk ${TEMP_BQ_DATASET} || true

    LOCATION=us-central1

    echo "Creating bucket..."
    gsutil mb -p $PROJECT -c regional -l $LOCATION gs://${TEMP_GCS_BUCKET}/ || true
}

function create_tables {
    for file in $(ls bigquery/*.sql); do
        TABLE="$(basename $file .sql)"
        QUERY="$(cat $file | tr "\n" " ")"

        echo "  Creating aux table $TABLE"
        bq --location=US query \
            --destination_table "$PROJECT:$TEMP_BQ_DATASET.$TABLE" \
            --replace \
            --use_legacy_sql=false \
            --format none \
            "$QUERY"
    done
}

function export_tables {
    for file in $(ls bigquery/*.sql); do
        TABLE="$(basename $file .sql)"
        FOLDER="gs://${TEMP_GCS_BUCKET}/batch_import/$TABLE"
        gsutil rm ${FOLDER}/** || true
        echo "  Exporting table $TABLE to bucket $FOLDER"
        bq --location=US extract \
            --compression GZIP \
            --destination_format CSV \
            --field_delimiter , \
            --noprint_header \
            --format none \
            "$PROJECT:$TEMP_BQ_DATASET.$TABLE" \
            "$FOLDER/$TABLE-*.csv.gz"
    done
}

function download_datasets {
    sudo rm -rf /tmp/datasets
    mkdir /tmp/datasets
    gsutil -m cp -r "gs://${TEMP_GCS_BUCKET}/batch_import/*" /tmp/datasets
    sudo chown -R neo4j:adm /tmp/datasets

    for dataset in $(ls /tmp/datasets); do
        sudo -u neo4j rm -rf $IMPORT_FOLDER/$dataset
    done

    sudo -u neo4j mv /tmp/datasets/* $IMPORT_FOLDER
    sudo -u neo4j rm -rf /tmp/datasets
}


function run_import {
    sudo -u neo4j rm -rf /var/lib/neo4j/data/databases/ethereum.db
    sudo -u neo4j neo4j-admin import \
        --database ethereum.db \
        --report-file /tmp/import-report.txt \
        --nodes:Address "headers/addresses.csv,${IMPORT_FOLDER}/addresses/addresses-.*" \
        --nodes:Block "headers/blocks.csv,${IMPORT_FOLDER}/blocks/blocks-.*" \
        --relationships:transaction "headers/transactions.csv,${IMPORT_FOLDER}/transactions/transactions-.*"
}

create_temp_resources
create_tables
export_tables
download_datasets
run_import

