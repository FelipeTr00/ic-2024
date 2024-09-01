select cnae_1, cnae_1_descricao, * */from rais_estab
where cnae_1 like '21%'
or cnae_1 like '303%'
or cnae_1 like '26%'; -- as alta


select count(*) qtd,
       B.populacao,
       B.id_municipio_nome
from rais_estab A
join municipios B
on A.id_municipio = B.id_municipio
where cnae_1_descricao is not null
group by A.id_municipio;
-- limit 10;

SELECT
    B.id_municipio,
    B.populacao,
    B.id_municipio_nome,
    (
        SELECT COUNT(*)
        FROM rais_estab A
        WHERE (A.cnae_1 LIKE '21%'
               OR A.cnae_1 LIKE '303%'
               OR A.cnae_1 LIKE '26%')
          AND A.id_municipio = B.id_municipio
    ) AS alta_qtd
FROM municipios B
GROUP BY B.id_municipio, B.populacao, B.id_municipio_nome
order by alta_qtd desc;

SELECT
    B.id_municipio,
    B.populacao,
    B.id_municipio_nome,
    (
        SELECT COUNT(*)
        FROM rais_estab A
        WHERE (A.cnae_1 LIKE '21%'
               OR A.cnae_1 LIKE '303%'
               OR A.cnae_1 LIKE '26%')
          AND A.id_municipio = B.id_municipio
    ) AS alta_qtd
FROM municipios B
GROUP BY B.id_municipio, B.populacao, B.id_municipio_nome
order by alta_qtd desc;

WITH alta_estab AS (
    SELECT id_municipio, COUNT(*) AS alta_qtd
    FROM rais_estab
    WHERE cnae_1 LIKE '21%'
       OR cnae_1 LIKE '303%'
       OR cnae_1 LIKE '26%'
    GROUP BY id_municipio
),
    media_alta_estab AS (
        SELECT id_municipio, COUNT(*) AS media_alta_qtd
    FROM rais_estab
    WHERE cnae_1 LIKE '251%'
       OR cnae_1 LIKE '29%'
       OR cnae_1 LIKE '325%'
       OR cnae_1 LIKE '28%'
       OR cnae_1 LIKE '20%'
       OR cnae_1 LIKE '27%'
    GROUP BY id_municipio
    )
SELECT
    A.id_municipio,
    A.id_municipio_nome,
    A.populacao,
    COALESCE(B.alta_qtd, 0) AS alta_qtd,
    COALESCE(C.media_alta_qtd, 0) AS media_alta_qtd
FROM municipios A
LEFT JOIN alta_estab B
ON A.id_municipio = B.id_municipio
LEFT JOIN media_alta_estab C
ON A.id_municipio = C.id_municipio
order by alta_qtd desc;
