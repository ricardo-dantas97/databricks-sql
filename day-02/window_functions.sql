-- Databricks notebook source
WITH tbl_vendas_vendedores AS (
  SELECT 
      idVendedor
      , COUNT(*) qtd_vendas
  FROM silver_olist.item_pedido
  GROUP BY 1
)
, row_number AS (
  SELECT t1.*
       , t2.descUF AS uf
       , ROW_NUMBER() OVER(PARTITION BY descUF ORDER BY qtd_vendas DESC) AS rank
  FROM tbl_vendas_vendedores AS t1
  LEFT JOIN silver_olist.vendedor AS t2 ON t1.idVendedor = t2.idVendedor
  QUALIFY rank <= 10
)
SELECT *
FROM row_number
ORDER BY uf, qtd_vendas DESC
