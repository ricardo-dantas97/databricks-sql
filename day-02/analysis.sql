-- Databricks notebook source
-- Qual categoria tem mais produtos vendidos?

SELECT 
  t2.descCategoria categoria
  , COUNT(*) qtd
FROM silver_olist.item_pedido AS t1
LEFT JOIN silver_olist.produto AS t2
ON t1.idProduto = t2.idProduto
GROUP BY t2.descCategoria
ORDER BY 2 DESC
LIMIT 5

-- COMMAND ----------

-- Qual categoria tem produtos mais caros em média?

SELECT 
  t2.descCategoria AS categoria
  , ROUND(AVG(t1.vlPreco), 2) AS preco_medio
FROM silver_olist.item_pedido AS t1
LEFT JOIN silver_olist.produto AS t2
ON t1.idProduto = t2.idProduto
GROUP BY t2.descCategoria
ORDER BY 2 DESC
LIMIT 5

-- COMMAND ----------

-- Os clientes de qual estado pagam mais frete?

SELECT 
  t3.descUF AS uf
  , ROUND(AVG(t1.vlFrete), 2) AS frete
FROM silver_olist.item_pedido AS t1
JOIN silver_olist.pedido t2 ON t1.idPedido = t2.idPedido 
JOIN silver_olist.cliente AS t3 ON t2.idCliente = t3.idCliente
GROUP BY 1
HAVING AVG(t1.vlFrete) >= 40
ORDER BY 2 DESC

