	SELECT NP.numpedido
          ,NP.dtPedido
	      ,V.id
	FROM (SELECT DISTINCT numpedido
	                     ,dtpedido
	                     ,nomevendedor
		  FROM {{source("raw","raw_mentloja")}}) AS NP
	LEFT JOIN {{source("dbt_nfigueira","dim_pedido")}} AS P
	ON NP.numPedido = P.numPedido
	JOIN {{source("dbt_nfigueira","dim_vendedor")}} AS V 
	ON NP.nomevendedor = V.nomevendedor
	WHERE P.numPedido IS NULL
	ORDER BY 1


