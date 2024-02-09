WITH NATION AS (
    SELECT
        N_NATIONKEY,
        N_NAME,
        N_REGIONKEY,
        SRC AS N_SRC
    FROM {{ ref('raw_vault__ref_nation') }}
    QUALIFY LEAD(REF_LOAD_DTS) OVER (PARTITION BY HASHKEY ORDER BY REF_LOAD_DTS) IS NULL
),
REGION AS (
    SELECT
        R_REGIONKEY,
        R_NAME,
        SRC AS R_SRC
    FROM {{ ref('raw_vault__ref_region') }}
    QUALIFY LEAD(REF_LOAD_DTS) OVER (PARTITION BY HASHKEY ORDER BY REF_LOAD_DTS) IS NULL
)
SELECT
    N.N_NATIONKEY,
    N.N_NAME,
    R.R_NAME,
    N.N_SRC,
    R.R_SRC
FROM NATION N
INNER JOIN REGION R
ON N.N_REGIONKEY = R.R_REGIONKEY