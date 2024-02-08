WITH LINK AS (
    SELECT
    LCO_HASHKEY,
    O_HASHKEY,
    C_HASHKEY
    FROM {{ ref('raw_vault__link_customer_order') }}
),
ORDERS AS (
    SELECT
    HASHKEY,
    O_ORDERSTATUS,
    O_TOTALPRICE,
    O_ORDERDATE,
    O_ORDERPRIORITY,
    O_CLERK,
    O_SHIPPRIORITY
    FROM {{ ref('raw_vault__sat_orders') }}
    QUALIFY LEAD(SAT_LOAD_DTS) OVER (PARTITION BY HASHKEY ORDER BY SAT_LOAD_DTS) IS NULL
)
SELECT
    L.O_HASHKEY,
    L.C_HASHKEY,
    O.O_ORDERSTATUS,
    O.O_TOTALPRICE,
    O.O_ORDERDATE,
    O.O_ORDERPRIORITY,
    O.O_CLERK,
    O.O_SHIPPRIORITY
FROM LINK L
LEFT JOIN ORDERS O
ON L.O_HASHKEY = O.HASHKEY





