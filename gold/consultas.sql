-- Verifica os 5 melhores e 5 piores munincípios levando em conta desempenho
WITH MediaMunicipios AS (
    SELECT 
        l.NOM_MUN AS Municipio,
        ROUND(AVG((f.VAL_NOT_NAT + f.VAL_NOT_HUM + f.VAL_NOT_LIN + f.VAL_NOT_MAT + f.VAL_NOT_RED) / 5), 2) AS Media_Geral
    FROM dw.FAT_DES f
    JOIN dw.DIM_LOC l ON f.LOC_SRK = l.LOC_SRK
    WHERE f.IND_PRE_NAT = 1 
      AND f.IND_PRE_HUM = 1 
      AND f.IND_PRE_LIN = 1 
      AND f.IND_PRE_MAT = 1
    GROUP BY l.NOM_MUN
),
Top5 AS (
    SELECT 'Melhores Desempenhos' AS Categoria, Municipio, Media_Geral
    FROM MediaMunicipios
    ORDER BY Media_Geral DESC
    LIMIT 5
),
Bottom5 AS (
    SELECT 'Piores Desempenhos' AS Categoria, Municipio, Media_Geral
    FROM MediaMunicipios
    ORDER BY Media_Geral ASC
    LIMIT 5
)
SELECT * FROM Top5
UNION ALL
SELECT * FROM Bottom5
ORDER BY Media_Geral DESC;

-- CTE (1) = Faz uma relação da faixa de renda familiar com a média da nota do ENEM com a qtd de pessoas nessa faixa 
WITH CalculoDesempenho AS (
    SELECT 
        SOC_SRK,
        (VAL_NOT_NAT + VAL_NOT_HUM + VAL_NOT_LIN + VAL_NOT_MAT + VAL_NOT_RED) / 5 AS media_aluno
    FROM dw.FAT_DES
    WHERE IND_PRE_NAT = 1 
      AND IND_PRE_HUM = 1 
      AND IND_PRE_LIN = 1 
      AND IND_PRE_MAT = 1
)
SELECT 
    s.COD_REN_FAM AS Faixa_Renda,
    ROUND(AVG(d.media_aluno), 2) AS Media_Academica_da_Faixa,
    COUNT(*) AS Qtd_Candidatos
FROM CalculoDesempenho d
JOIN dw.DIM_SOC s ON d.SOC_SRK = s.SOC_SRK
GROUP BY s.COD_REN_FAM
ORDER BY s.COD_REN_FAM;

-- CTE(2) = Mostra faixa de renda familiar, os inscritos nessa faixa, quantos faltantes e o percentual de faltantes
WITH StatusCandidato AS (
    SELECT 
        SOC_SRK,
        CASE 
            WHEN IND_PRE_NAT = 0 OR IND_PRE_HUM = 0 OR IND_PRE_LIN = 0 OR IND_PRE_MAT = 0 
            THEN 1 
            ELSE 0 
        END AS foi_faltante
    FROM dw.FAT_DES
)
SELECT 
    s.COD_REN_FAM AS Faixa_Renda,
    COUNT(*) AS Total_Inscritos,
    SUM(c.foi_faltante) AS Qtd_Faltantes,
    ROUND(
        (SUM(c.foi_faltante) * 100.0) / COUNT(*), 
        2
    ) AS Percentual_Faltantes
FROM StatusCandidato c
JOIN dw.DIM_SOC s ON c.SOC_SRK = s.SOC_SRK
GROUP BY s.COD_REN_FAM
ORDER BY s.COD_REN_FAM;

-- Divisão de pessoas que escolheram linguagens
SELECT 
    CASE p.TIP_LIN 
        WHEN 0 THEN 'Inglês'
        WHEN 1 THEN 'Espanhol'
        ELSE 'Não Informado'
    END AS Lingua_Estrangeira,
    COUNT(*) AS Total_Candidatos,
    ROUND(
        (COUNT(*) * 100.0) / SUM(COUNT(*)) OVER(), 
        2
    ) AS Percentual_Representatividade
FROM dw.FAT_DES f
JOIN dw.DIM_PRV p ON f.PRV_SRK = p.PRV_SRK
GROUP BY p.TIP_LIN
ORDER BY Total_Candidatos DESC;

-- Munincípios com qntd de desistentes VERIFICAR SE PRECISA LIMITAR NO BI
SELECT 
    l.NOM_MUN AS Municipio,
    COUNT(*) AS Total_Desistentes
FROM dw.FAT_DES f
JOIN dw.DIM_LOC l ON f.LOC_SRK = l.LOC_SRK 
WHERE 
    f.IND_PRE_HUM = 1 AND f.IND_PRE_LIN = 1
    AND 
    (f.IND_PRE_NAT = 0 OR f.IND_PRE_MAT = 0)
GROUP BY l.NOM_MUN
ORDER BY Total_Desistentes DESC;
WITH NotasEstrangeiros AS (
    SELECT 
        p.COD_NAC,
        (f.VAL_NOT_NAT + f.VAL_NOT_HUM + f.VAL_NOT_LIN + f.VAL_NOT_MAT + f.VAL_NOT_RED) / 5 AS media_aluno
    FROM dw.FAT_DES f
    JOIN dw.DIM_PAR p ON f.PAR_SRK = p.PAR_SRK
    WHERE f.IND_PRE_NAT = 1 
      AND f.IND_PRE_HUM = 1 
      AND f.IND_PRE_LIN = 1 
      AND f.IND_PRE_MAT = 1
)
SELECT 
    CASE n.COD_NAC
        WHEN 3 THEN 'Estrangeiro'
        WHEN 1 THEN 'Brasileiro Nato'
        WHEN 2 THEN 'Brasileiro Naturalizado'
        WHEN 4 THEN 'Brasileiro Nascido no Exterior'
        ELSE 'Não Informado'
    END AS Nacionalidade,
    COUNT(*) AS Qtd_Candidatos,
    ROUND(AVG(n.media_aluno), 2) AS Media_Academica
FROM NotasEstrangeiros n
GROUP BY n.COD_NAC
ORDER BY Media_Academica DESC;

-- Desempenho por raça
WITH CalculoNotasRaca AS (
    SELECT 
        p.COD_COR_RAC,
        (f.VAL_NOT_NAT + f.VAL_NOT_HUM + f.VAL_NOT_LIN + f.VAL_NOT_MAT + f.VAL_NOT_RED) / 5 AS media_candidato
    FROM dw.FAT_DES f
    JOIN dw.DIM_PAR p ON f.PAR_SRK = p.PAR_SRK
    WHERE f.IND_PRE_NAT = 1 
      AND f.IND_PRE_HUM = 1 
      AND f.IND_PRE_LIN = 1 
      AND f.IND_PRE_MAT = 1
)
SELECT 
    CASE c.COD_COR_RAC
        WHEN 0 THEN 'Não declarado'
        WHEN 1 THEN 'Branca'
        WHEN 2 THEN 'Preta'
        WHEN 3 THEN 'Parda'
        WHEN 4 THEN 'Amarela'
        WHEN 5 THEN 'Indígena'
        ELSE 'Outros/Nulo'
    END AS Cor_Raca,
    COUNT(*) AS Total_Candidatos,
    ROUND(AVG(c.media_candidato), 2) AS Media_Geral_Enem
FROM CalculoNotasRaca c
GROUP BY c.COD_COR_RAC
ORDER BY Media_Geral_Enem DESC;

-- Impacto do acesso à internet no desempenho médio
WITH NotasInternet AS (
    SELECT 
        s.IND_ACE_INT,
        (f.VAL_NOT_NAT + f.VAL_NOT_HUM + f.VAL_NOT_LIN + f.VAL_NOT_MAT + f.VAL_NOT_RED) / 5 AS media_aluno
    FROM dw.FAT_DES f
    JOIN dw.DIM_SOC s ON f.SOC_SRK = s.SOC_SRK
    WHERE f.IND_PRE_NAT = 1 
      AND f.IND_PRE_HUM = 1 
      AND f.IND_PRE_LIN = 1 
      AND f.IND_PRE_MAT = 1
)
SELECT 
    CASE IND_ACE_INT
        WHEN 'A' THEN 'Não Possui'
        WHEN 'B' THEN 'Possui'
        ELSE 'Não Informado'
    END AS Acesso_Internet,
    COUNT(*) AS Qtd_Candidatos,
    ROUND(AVG(media_aluno), 2) AS Media_Geral
FROM NotasInternet
GROUP BY IND_ACE_INT
ORDER BY Media_Geral DESC;

-- Desempenho por escolaridade da mãe (Indicador forte de capital cultural)
WITH NotasEscolaridadeMae AS (
    SELECT 
        s.COD_ESC_MAE,
        (f.VAL_NOT_NAT + f.VAL_NOT_HUM + f.VAL_NOT_LIN + f.VAL_NOT_MAT + f.VAL_NOT_RED) / 5 AS media_aluno
    FROM dw.FAT_DES f
    JOIN dw.DIM_SOC s ON f.SOC_SRK = s.SOC_SRK
    WHERE f.IND_PRE_NAT = 1 
      AND f.IND_PRE_HUM = 1 
      AND f.IND_PRE_LIN = 1 
      AND f.IND_PRE_MAT = 1
)
SELECT 
    CASE COD_ESC_MAE
        WHEN 'A' THEN 'Nunca estudou'
        WHEN 'B' THEN 'Não completou a 4ª série/5º ano do Ensino Fundamental'
        WHEN 'C' THEN 'Completou a 4ª série/5º ano, mas não completou a 8ª série/9º ano do Ensino Fundamental'
        WHEN 'D' THEN 'Completou a 8ª série/9º ano do Ensino Fundamental, mas não completou o Ensino Médio'
        WHEN 'E' THEN 'Completou o Ensino Médio, mas não completou a Faculdade'
        WHEN 'F' THEN 'Completou a Faculdade, mas não completou a Pós-graduação'
        WHEN 'G' THEN 'Completou a Pós-graduação'
        WHEN 'H' THEN 'Não sabe'
        ELSE 'Não Informado'
    END AS Escolaridade_Mae,
    COUNT(*) AS Qtd_Candidatos,
    ROUND(AVG(media_aluno), 2) AS Media_Geral
FROM NotasEscolaridadeMae
GROUP BY COD_ESC_MAE
ORDER BY COD_ESC_MAE;

-- Comparativo de desempenho por Gênero
WITH NotasGenero AS (
    SELECT 
        p.TIP_SEX,
        (f.VAL_NOT_NAT + f.VAL_NOT_HUM + f.VAL_NOT_LIN + f.VAL_NOT_MAT + f.VAL_NOT_RED) / 5 AS media_aluno
    FROM dw.FAT_DES f
    JOIN dw.DIM_PAR p ON f.PAR_SRK = p.PAR_SRK
    WHERE f.IND_PRE_NAT = 1 
      AND f.IND_PRE_HUM = 1 
      AND f.IND_PRE_LIN = 1 
      AND f.IND_PRE_MAT = 1
)
SELECT 
    CASE TIP_SEX
        WHEN 'M' THEN 'Masculino'
        WHEN 'F' THEN 'Feminino'
        ELSE 'Não Informado'
    END AS Genero,
    COUNT(*) AS Qtd_Candidatos,
    ROUND(AVG(media_aluno), 2) AS Media_Geral
FROM NotasGenero
GROUP BY TIP_SEX
ORDER BY Media_Geral DESC;

-- Verifica os 5 municípios com maior e menor desvio padrão (Desigualdade de notas)
WITH DesvioMunicipios AS (
    SELECT 
        l.NOM_MUN AS Municipio,
        ROUND(STDDEV((f.VAL_NOT_NAT + f.VAL_NOT_HUM + f.VAL_NOT_LIN + f.VAL_NOT_MAT + f.VAL_NOT_RED) / 5), 2) AS Desvio_Padrao
    FROM dw.FAT_DES f
    JOIN dw.DIM_LOC l ON f.LOC_SRK = l.LOC_SRK
    WHERE f.IND_PRE_NAT = 1 
      AND f.IND_PRE_HUM = 1 
      AND f.IND_PRE_LIN = 1 
      AND f.IND_PRE_MAT = 1
    GROUP BY l.NOM_MUN
    HAVING COUNT(*) > 1
),
Top5_Desvio AS (
    SELECT 'Maior Desvio (Mais Desigual)' AS Categoria, Municipio, Desvio_Padrao
    FROM DesvioMunicipios
    ORDER BY Desvio_Padrao DESC
    LIMIT 5
),
Bottom5_Desvio AS (
    SELECT 'Menor Desvio (Mais Homogêneo)' AS Categoria, Municipio, Desvio_Padrao
    FROM DesvioMunicipios
    ORDER BY Desvio_Padrao ASC
    LIMIT 5
)
SELECT * FROM Top5_Desvio
UNION ALL
SELECT * FROM Bottom5_Desvio
ORDER BY Desvio_Padrao DESC;


-- Maiores notas por prova e município

SELECT DISTINCT
    L.NOM_MUN AS Municipio,
    F.VAL_NOT_MAT AS Nota_Matematica
FROM dw.FAT_DES F
INNER JOIN dw.DIM_LOC L ON F.LOC_SRK = L.LOC_SRK
WHERE F.VAL_NOT_MAT IS NOT NULL
ORDER BY F.VAL_NOT_MAT DESC
LIMIT 6;


SELECT DISTINCT
    L.NOM_MUN AS Municipio,
    F.VAL_NOT_NAT AS Nota_Natureza
FROM dw.FAT_DES F
INNER JOIN dw.DIM_LOC L ON F.LOC_SRK = L.LOC_SRK
WHERE F.VAL_NOT_NAT IS NOT NULL
ORDER BY F.VAL_NOT_NAT DESC
LIMIT 6;


SELECT DISTINCT
    L.NOM_MUN AS Municipio,
    F.VAL_NOT_HUM AS Nota_Humanas
FROM dw.FAT_DES F
INNER JOIN dw.DIM_LOC L ON F.LOC_SRK = L.LOC_SRK
WHERE F.VAL_NOT_HUM IS NOT NULL
ORDER BY F.VAL_NOT_HUM DESC
LIMIT 6;


SELECT DISTINCT
    L.NOM_MUN AS Municipio,
    F.VAL_NOT_LIN AS Nota_Linguagens
FROM dw.FAT_DES F
INNER JOIN dw.DIM_LOC L ON F.LOC_SRK = L.LOC_SRK
WHERE F.VAL_NOT_LIN IS NOT NULL
ORDER BY F.VAL_NOT_LIN DESC
LIMIT 6;