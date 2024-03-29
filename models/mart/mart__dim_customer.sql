WITH HUB AS (
    SELECT
    HASHKEY,
    C_CUSTKEY,
    HUB_LOAD_DTS,
    SRC AS SRC
    FROM {{ ref('raw_vault__hub_customer') }}
),
PIT AS (
    SELECT
    HASHKEY,
    C_CUSTKEY,
    PIT_LOAD_DTS,
    C_HUB_LOAD_DTS,
    C_SAT_INFO_LOAD_DTS,
    C_SAT_ACC_LOAD_DTS
    FROM {{ ref('business_vault__pit_customer') }}
    QUALIFY LEAD(PIT_LOAD_DTS) OVER (PARTITION BY HASHKEY ORDER BY PIT_LOAD_DTS) IS NULL
),
SAT_ACC AS (
    SELECT
    HASHKEY,
    C_ACCTBAL,
    C_MKTSEGMENT,
    C_COMMENT,
    SAT_LOAD_DTS
    FROM {{ ref('raw_vault__sat_customer_acc') }}
    QUALIFY LEAD(SAT_LOAD_DTS) OVER (PARTITION BY HASHKEY ORDER BY SAT_LOAD_DTS) IS NULL
),
SAT_INFO AS (
    SELECT
    HASHKEY,
    C_NAME,
    C_ADDRESS,
    C_NATIONKEY,
    C_PHONE,
    SAT_LOAD_DTS
    FROM {{ ref('raw_vault__sat_customer_info') }}
    QUALIFY LEAD(SAT_LOAD_DTS) OVER (PARTITION BY HASHKEY ORDER BY SAT_LOAD_DTS) IS NULL
)
SELECT
    H.HASHKEY,
    H.C_CUSTKEY,
    I.C_NAME,
    I.C_ADDRESS,
    I.C_NATIONKEY,
    I.C_PHONE,    
    A.C_ACCTBAL,
    A.C_MKTSEGMENT,
    A.C_COMMENT,
    H.SRC AS SRC
FROM HUB H
LEFT JOIN SAT_ACC A ON 
A.HASHKEY = H.HASHKEY
LEFT JOIN SAT_INFO I 
ON I.HASHKEY = H.HASHKEY
LEFT JOIN PIT P 
ON P.HASHKEY = H.HASHKEY
AND P.C_SAT_INFO_LOAD_DTS = I.SAT_LOAD_DTS 
AND P.C_SAT_ACC_LOAD_DTS = A.SAT_LOAD_DTS
AND P.C_HUB_LOAD_DTS = H.HUB_LOAD_DTS


