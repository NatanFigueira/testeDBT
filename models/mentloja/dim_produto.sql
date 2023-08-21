	SELECT ROW_NUMBER() OVER() + T1.MAXID AS idProduto
	      ,NP.produto
	      ,NP.vlproduto
	FROM (SELECT DISTINCT produto
	                     ,vlproduto
		  FROM {{source('raw','raw_mentloja')}}) AS NP
    LEFT JOIN {{source('dbt_nfigueira','dim_produto')}} AS P
	ON NP.produto = P.produto
	CROSS JOIN (SELECT COALESCE(MAX(idProduto), 0) AS MAXID FROM {{source('dbt_nfigueira','dim_produto')}}) AS T1
	WHERE P.produto IS NULL


    