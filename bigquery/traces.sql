SELECT
    trace_id,
    transaction_hash,
    transaction_index,
    COALESCE(from_address, '0x0000000000000000000000000000000000000000') AS from_address,
    COALESCE(to_address, '0x0000000000000000000000000000000000000000') AS to_address,
    value,
    trace_type,
    call_type,
    reward_type,
    gas,
    gas_used,
    subtraces,
    trace_address,
    error,
    status,
    FORMAT_TIMESTAMP("%Y-%m-%dT%X%Ez", block_timestamp) AS block_timestamp,
    block_number
FROM `bigquery-public-data.crypto_ethereum.traces`
WHERE DATE(block_timestamp) >= @start_date AND DATE(block_timestamp) <= @end_date
