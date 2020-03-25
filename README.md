# EthereumETL for Neo4j

ETL for moving Ethereum data to a Neo4j database.

1. Create a new VM using the official Neo4j image:

```bash
gcloud compute instances create ethereum-neo4j-instance-0 \
    --image neo4j-enterprise-1-3-5-7-apoc \
    --image-project launcher-public \
    --machine-type n1-standard-2 \
    --boot-disk-size 1500GB \
    --tags neo4j \
    --zone us-central1-a \
    --boot-disk-type pd-ssd
```

2. ssh to the instance and clone https://github.com/blockchain-etl/ethereum-etl-neo4j:

```bash
gcloud auth login
export PROJECT=<your-project>

git clone https://github.com/blockchain-etl/ethereum-etl-neo4j
cd ethereum-etl-neo4j
```

3. Run the import:

```bash
nohup bash batch-import.sh &
tail -f nohup.out
```

4. Open the Neo4j console at https://<vm_external_ip>:7473/browser/ and execute the query:

```bash
MATCH (address: Address)
RETURN address
LIMIT 10
```

Notes:
- values are loaded with type string to Neo4j as there is only Integer and Float types there. Use exact math function
in your queries to convert to BigInteger https://neo4j.com/docs/labs/apoc/current/mathematical/exact-math-functions/.