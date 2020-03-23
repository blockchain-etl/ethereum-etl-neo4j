SELECT DISTINCT from_address
FROM `bigquery-public-data.crypto_ethereum.transactions`
WHERE DATE(block_timestamp) < '2020-03-22'
UNION DISTINCT
SELECT DISTINCT to_address
FROM `bigquery-public-data.crypto_ethereum.transactions`
WHERE DATE(block_timestamp) < '2020-03-22'
