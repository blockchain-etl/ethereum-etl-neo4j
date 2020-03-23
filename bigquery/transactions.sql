SELECT
    `hash`,
    nonce,
    transaction_index,
    from_address,
    to_address,
    value,
    gas,
    gas_price,
    receipt_cumulative_gas_used,
    receipt_gas_used,
    receipt_contract_address,
    receipt_root,
    receipt_status,
    FORMAT_TIMESTAMP("%Y-%m-%dT%X%Ez", block_timestamp) AS block_timestamp,
    block_number,
    block_hash
FROM `bigquery-public-data.crypto_ethereum.transactions`
WHERE DATE(block_timestamp) < '2020-03-22'