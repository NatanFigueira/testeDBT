	SELECT ROW_NUMBER() OVER(
		   PARTITION BY NIP.numpedido
		   ORDER BY PR.id) + T1.MAXID AS idItemPedido
	      ,NIP.numPedido AS fkPedido
	      ,PR.id AS fkProduto
	      ,NIP.qtproduto AS qtdProduto
	FROM (SELECT qtproduto,
			     numpedido,
			     produto
		  FROM {{source('raw', 'raw_mentloja')}}) AS NIP
	LEFT JOIN {{source('dbt_nfigueira', 'dim_produto')}} AS PR
	ON PR.produto = NIP.Produto 
	LEFT JOIN {{source('dbt_nfigueira', 'dim_item_pedido')}} AS IP
	ON NIP.numpedido = IP.fkPedido
	AND IP.fkProduto = PR.id
	CROSS JOIN (SELECT COALESCE(MAX(idItemPedido), 0) AS MAXID FROM {{source('dbt_nfigueira', 'dim_item_pedido')}}) AS T1
	WHERE IP.fkProduto IS NULL
	AND IP.fkPedido IS NULL

