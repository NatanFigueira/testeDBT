    SELECT ROW_NUMBER() OVER() + T1.MAXID AS id
          ,NV.nomeVendedor 
    FROM (SELECT DISTINCT nomeVendedor 
          FROM {{source('raw','raw_mentloja')}}) AS NV 
    LEFT JOIN {{source('dbt_nfigueira','dim_vendedor')}} AS V 
    ON NV.nomeVendedor = V.nomeVendedor 
    CROSS JOIN (SELECT COALESCE(MAX(id), 0) AS MAXID FROM {{source('dbt_nfigueira','dim_vendedor')}}) AS T1 
    WHERE V.nomeVendedor IS NULL



    