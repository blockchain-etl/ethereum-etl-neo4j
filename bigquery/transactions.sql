SELECT
    `hash`,
    nonce,
    transaction_index,
    from_address,
    COALESCE(to_address, receipt_contract_address) AS to_address,
    value,
    gas,
    gas_price,
    receipt_cumulative_gas_used,
    receipt_gas_used,
    receipt_contract_address,
    receipt_root,
    receipt_status,
    FORMAT_TIMESTAMP("%Y-%m-%dT%X%Ez", block_timestamp) AS block_timestamp,
    block_number
FROM `bigquery-public-data.crypto_ethereum.transactions`
WHERE DATE(block_timestamp) >= @start_date AND DATE(block_timestamp) <= @end_date