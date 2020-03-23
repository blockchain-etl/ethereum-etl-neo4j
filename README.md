# ethereum-etl-neo4j
ETL for moving Ethereum data to Neo4j database

gcloud compute instances create ethereum-neo4j-instance-0 \
    --image neo4j-enterprise-1-3-5-7-apoc \
    --image-project launcher-public \
    --machine-type n1-standard-2 \
    --boot-disk-size 500GB \
    --tags neo4j \
    --zone us-central1-a \
    --boot-disk-type pd-ssd
    

https://{externalIp}:7473/browser/