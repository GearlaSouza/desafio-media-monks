-- 1. Qual marca teve o maior volume de vendas?
select
    v.marca,
    v.id_marca,
    SUM(v.vendas) as qtd_vendas
from venda_veiculo as v
GROUP BY v.id_marca
ORDER by qtd_vendas DESC
    LIMIT 1;

-- Resposta: Fiat, com 433 vendas.


-- 2. Qual veículo gerou a maior e menor receita?
SELECT (select nome
        from venda_veiculo
        GROUP BY nome
        ORDER BY sum(valor_veiculo) asc) as menor_receita,
       (select
            nome
        from venda_veiculo
        GROUP BY nome
        ORDER BY sum(valor_veiculo) DESC) as maior_receita

-- Resposta: Menor receita 206, maior receita Forester


-- 3. Qual a média de vendas do ano por marca?
select
    v.marca,
    v.id_marca,
    ROUND(AVG(v.vendas), 2) as media_vendas,
    strftime('%Y', date(data)) AS ano
from venda_veiculo as v
GROUP BY v.id_marca;

-- Resposta: 
-- Fiat - média = 19.68
-- Volkswagem - média = 18.81
-- Kia - média = 23
-- Peugeot - média = 11.56
-- Toyota - média = 7.88
-- Nissan - média = 3.29
-- Mitsubishi - média = 3.8
-- Subaru - média = 7.43
-- Chevrolet - média = 3.67
-- JaC Motors - média = 2.17
-- Renault - média = 4.75


-- 4. Quais marcas geraram uma receita maior com número menor de vendas?
select
    v.marca,
    (select
         sum(vv.valor_veiculo)
     from venda_veiculo vv
     where vv.id_marca = v.id_marca) as receita,
    (select
         SUM(vvv.vendas) as qtd_vendas
     from venda_veiculo as vvv
     where v.id_marca = vvv.id_marca) as qtd_vendas
from venda_veiculo v
GROUP BY v.id_marca
ORDER by receita desc, qtd_vendas

-- Resposta: Subaru e Mitsubishi


-- 5. Existe alguma relação entre os veículos mais vendidos?
SELECT * FROM venda_veiculo v where v.nome in (select
                                                   vv.nome
                                               from venda_veiculo as vv
                                               GROUP BY vv.nome
                                               ORDER by SUM(vv.vendas) DESC
    LIMIT 3);

-- Resposta: Os veículos Mob, Up e Picanto tiveram vendas todos os dias no intervalo de 01-01-2022 a 12-01-2022.
