SELECT
    FORMAT_TIMESTAMP("%Y-%m-%dT%X%Ez", timestamp) AS timestamp,
    number,
    `hash`,
    parent_hash,
    nonce,
    sha3_uncles,
    logs_bloom,
    transactions_root,
    state_root,
    receipts_root,
    miner,
    difficulty,
    total_difficulty,
    size,
    extra_data,
    gas_limit,
    gas_used,
    transaction_count
FROM `bigquery-public-data.crypto_ethereum.blocks`
WHERE DATE(timestamp) >= @start_date AND DATE(timestamp) <= @end_date
