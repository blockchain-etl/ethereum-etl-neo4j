SELECT DISTINCT from_address as address
FROM `bigquery-public-data.crypto_ethereum.transactions`
WHERE DATE(block_timestamp) < @end_date

UNION DISTINCT

SELECT DISTINCT COALESCE(to_address, receipt_contract_address),
FROM `bigquery-public-data.crypto_ethereum.transactions`
WHERE DATE(block_timestamp) < @end_date

UNION DISTINCT

SELECT DISTINCT COALESCE(from_address, '0x0000000000000000000000000000000000000000')
FROM `bigquery-public-data.crypto_ethereum.traces`
WHERE DATE(block_timestamp) >= @start_date AND DATE(block_timestamp) <= @end_date

UNION DISTINCT

SELECT DISTINCT COALESCE(to_address, '0x0000000000000000000000000000000000000000')
FROM `bigquery-public-data.crypto_ethereum.traces`
WHERE DATE(block_timestamp) >= @start_date AND DATE(block_timestamp) <= @end_date

UNION DISTINCT

SELECT DISTINCT COALESCE(from_address, '0x0000000000000000000000000000000000000000')
FROM `bigquery-public-data.crypto_ethereum.token_transfers`
WHERE DATE(block_timestamp) >= @start_date AND DATE(block_timestamp) <= @end_date

UNION DISTINCT

SELECT DISTINCT COALESCE(to_address, '0x0000000000000000000000000000000000000000')
FROM `bigquery-public-data.crypto_ethereum.token_transfers`
WHERE DATE(block_timestamp) >= @start_date AND DATE(block_timestamp) <= @end_date