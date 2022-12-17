-- Databricks notebook source
-- Lista de vendedores que estão no estado com menos clientes
WITH tbl_estados AS (
  SELECT 
    descUf
    , COUNT(DISTINCT idClienteUnico) AS contagem
  FROM silver_olist.cliente
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1
)

SELECT idVendedor
FROM silver_olist.vendedor
WHERE descUF = (SELECT descUF FROM tbl_estados)

-- COMMAND ----------

-- Nota média dos pedidos dos vendedores de cada estado

WITH tbl_pedido_nota AS (
  SELECT idVendedor, vlNota
  FROM silver_olist.item_pedido AS t1
  LEFT JOIN silver_olist.avaliacao_pedido AS t2
  ON t1.idPedido = t2.idPedido
)
, tbl_avg_vendedor AS (
  SELECT 
    idVendedor
    , AVG(vlNota) AS avg_nota
  FROM tbl_pedido_nota
  GROUP BY 1
)
, tbl_vendedor_estado AS (
  SELECT 
      t1.*
      , t2.descUF
  FROM tbl_avg_vendedor AS t1
  LEFT JOIN silver_olist.vendedor AS t2
  ON t1.idVendedor = t2.idVendedor
)
SELECT 
    descUF AS uf
    , ROUND(AVG(avg_nota), 2) AS avg_nota
FROM tbl_vendedor_estado
GROUP BY descUF
ORDER BY 2 DESC
