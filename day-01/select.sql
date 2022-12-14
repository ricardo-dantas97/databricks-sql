-- Databricks notebook source
-- Consulta a partir de uma tabela
SELECT *
FROM silver_olist.pedido
LIMIT 5;

-- COMMAND ----------

-- Verificando a qtd de dias entre data estimada para entrega e data de entrega em si
-- Usando a função datediff
-- Adição de uma coluna condicional também para verificar se o pedido foi entregue no prazo
SELECT 
  idPedido
  , CASE 
      WHEN dtEntregue IS NOT NULL THEN
        CASE
            WHEN dtEstimativaEntrega >= dtEntregue THEN 1 
            ELSE 0 
        END
      ELSE null
    END AS entregue_prazo
  , dtEstimativaEntrega
  , dtEntregue
  , DATEDIFF(dtEstimativaEntrega, dtEntregue) AS datediff
FROM silver_olist.pedido
-- WHERE dtEntregue IS NOT NULL

-- COMMAND ----------

-- Filtrando pedidos com a situação 'delivered'
SELECT *
FROM silver_olist.pedido
WHERE LOWER(descSituacao) = 'delivered'
LIMIT 5;

-- COMMAND ----------

-- Validando os tipos de situações de pedidos existentes usando a função DISTINCT
SELECT DISTINCT descSituacao
FROM silver_olist.pedido;

-- COMMAND ----------

-- Realizando filtro com mais de uma condição (AND) e usando a função YEAR para extrair o ano de uma data
SELECT *
FROM silver_olist.pedido
WHERE descSituacao = 'shipped'
AND YEAR(dtPedido) = 2018

-- COMMAND ----------

-- Usando mais de uma condição, AND e OR
SELECT *
FROM silver_olist.pedido
WHERE (descSituacao = 'shipped' OR descSituacao = 'cancelled')
AND YEAR(dtPedido) = 2018
;

-- COMMAND ----------

-- Uso do operador IN, melhorando a query acima
SELECT *
FROM silver_olist.pedido
WHERE descSituacao IN ('shipped', 'cancelled')
AND YEAR(dtPedido) = 2018;
