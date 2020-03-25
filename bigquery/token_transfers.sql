SELECT
    token_address,
    COALESCE(from_address, '0x0000000000000000000000000000000000000000') AS from_address,
    COALESCE(to_address, '0x0000000000000000000000000000000000000000') AS to_address,
    value,
    transaction_hash,
    log_index,
    FORMAT_TIMESTAMP("%Y-%m-%dT%X%Ez", block_timestamp) AS block_timestamp,
    block_number
FROM `bigquery-public-data.crypto_ethereum.token_transfers`
WHERE DATE(block_timestamp) >= @start_date AND DATE(block_timestamp) <= @end_date
