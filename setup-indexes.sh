#!/usr/bin/env bash

NEO_HOST=localhost
NEO_PASSWORD=neo4j

cat create-indexes.cypher | cypher-shell -u neo4j -p $NEO_PASSWORD -a bolt://$NEO_HOST:7687