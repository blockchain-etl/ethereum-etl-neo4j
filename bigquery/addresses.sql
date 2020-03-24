SELECT DISTINCT from_address as address
FROM `bigquery-public-data.crypto_ethereum.transactions`
WHERE DATE(block_timestamp) < '2020-03-22'
UNION DISTINCT
SELECT DISTINCT COALESCE(to_address, receipt_contract_address) AS to_address,
FROM `bigquery-public-data.crypto_ethereum.transactions`
WHERE DATE(block_timestamp) < '2020-03-22'
