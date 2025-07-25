-- Desafio 1: Consulta de Vendedores Ativos
SELECT id_vendedor AS id, nome, salario
FROM vendedores
WHERE inativo = FALSE
ORDER BY nome ASC;

-- Desafio 2: Funcionários com Salário Acima da Média
SELECT id_vendedor AS id, nome, salario
FROM vendedores
WHERE salario > (
    SELECT AVG(salario) FROM vendedores
)
ORDER BY salario DESC;

-- Desafio 3: Resumo por Cliente
SELECT 
    c.id_cliente AS id, 
    c.razao_social, 
    COALESCE(SUM(p.valor_total), 0) AS total
FROM clientes c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.razao_social
ORDER BY total DESC;

-- Desafio 4: Situação por Pedido
SELECT 
    id_pedido AS id, 
    valor_total AS valor, 
    data_emissao AS data,
    CASE 
        WHEN data_cancelamento IS NOT NULL THEN 'CANCELADO'
        WHEN data_faturamento IS NOT NULL THEN 'FATURADO'
        ELSE 'PENDENTE'
    END AS situacao
FROM pedido;

-- Desafio 5: Produto Mais Vendido
SELECT 
    ip.id_produto,
    SUM(ip.quantidade) AS quantidade_vendida,
    SUM(ip.quantidade * ip.preco_praticado) AS total_vendido,
    COUNT(DISTINCT ip.id_pedido) AS pedidos,
    COUNT(DISTINCT p.id_cliente) AS clientes
FROM itens_pedido ip
JOIN pedido p ON p.id_pedido = ip.id_pedido
GROUP BY ip.id_produto
ORDER BY 
    quantidade_vendida DESC,
    total_vendido DESC
LIMIT 1;
