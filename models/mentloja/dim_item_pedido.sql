	SELECT ROW_NUMBER() OVER(
		   PARTITION BY NIP.numpedido
		   ORDER BY PR.idProduto) AS idItemPedido
	      ,NIP.numPedido AS fkPedido
	      ,PR.idProduto AS fkProduto
	      ,NIP.qtproduto AS qtdProduto
	FROM (SELECT qtproduto,
			     numpedido,
			     produto
		  FROM {{source('raw', 'raw_mentloja')}}) AS NIP
	LEFT JOIN {{source('dbt_nfigueira', 'dim_produto')}} AS PR
	ON PR.produto = NIP.Produto
	LEFT JOIN {{source('dbt_nfigueira', 'dim_item_pedido')}} AS IP
	ON NIP.numpedido = IP.fkPedido
	AND IP.fkProduto = PR.idProduto
	WHERE IP.fkProduto IS NULL
	AND IP.fkPedido IS NULL
    ORDER BY 1