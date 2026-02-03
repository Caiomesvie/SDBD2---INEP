-- Média por área de todos os municípios
SELECT 
    L.NOM_MUN,
    ROUND(AVG(f.VAL_NOT_NAT), 2) AS Media_Natureza,
    ROUND(AVG(f.VAL_NOT_HUM), 2) AS Media_Humanas,
    ROUND(AVG(f.VAL_NOT_LIN), 2) AS Media_Linguagens,
    ROUND(AVG(f.VAL_NOT_MAT), 2) AS Media_Matematica,
    ROUND(AVG(f.VAL_NOT_RED), 2) AS Media_Redacao,
    ROUND(AVG((f.VAL_NOT_NAT + f.VAL_NOT_HUM + f.VAL_NOT_LIN + f.VAL_NOT_MAT + f.VAL_NOT_RED) / 5), 2) AS Media_Geral
FROM dw.FAT_DES f
JOIN dw.DIM_LOC l ON f.LOC_SRK = l.LOC_SRK
WHERE f.IND_PRE_NAT = 1 
  AND f.IND_PRE_HUM = 1 
  AND f.IND_PRE_LIN = 1 
  AND f.IND_PRE_MAT = 1
GROUP BY l.NOM_MUN
ORDER BY Media_Geral ASC; 

-- Verifica os 5 municípios com maior desvio padrão
SELECT 
    l.NOM_MUN AS Municipio,
    ROUND(AVG((f.VAL_NOT_NAT + f.VAL_NOT_HUM + f.VAL_NOT_LIN + f.VAL_NOT_MAT + f.VAL_NOT_RED) / 5), 2) AS Media_Geral,
    ROUND(STDDEV((f.VAL_NOT_NAT + f.VAL_NOT_HUM + f.VAL_NOT_LIN + f.VAL_NOT_MAT + f.VAL_NOT_RED) / 5), 2) AS Desvio_Padrao
FROM dw.FAT_DES f
JOIN dw.DIM_LOC l ON f.LOC_SRK = l.LOC_SRK
WHERE f.IND_PRE_NAT = 1 
  AND f.IND_PRE_HUM = 1 
  AND f.IND_PRE_LIN = 1 
  AND f.IND_PRE_MAT = 1
GROUP BY l.NOM_MUN
HAVING COUNT(*) > 1
ORDER BY Desvio_Padrao DESC
LIMIT 25;

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

-- Distribuição de Notas da Redação 
WITH FaixasRedacao AS (
    SELECT 
        CASE 
            WHEN VAL_NOT_RED = 0 THEN '0. Zerou'
            WHEN VAL_NOT_RED BETWEEN 1 AND 200 THEN '1. Muito Baixa (1-200)'
            WHEN VAL_NOT_RED BETWEEN 201 AND 400 THEN '2. Baixa (201-400)'
            WHEN VAL_NOT_RED BETWEEN 401 AND 600 THEN '3. Média (401-600)'
            WHEN VAL_NOT_RED BETWEEN 601 AND 800 THEN '4. Boa (601-800)'
            WHEN VAL_NOT_RED BETWEEN 801 AND 999 THEN '5. Muito Boa (801-999)'
            WHEN VAL_NOT_RED = 1000 THEN '6. Nota Mil (1000)'
        END AS Faixa_Nota
    FROM dw.FAT_DES
    WHERE IND_PRE_LIN = 1 
      AND VAL_NOT_RED IS NOT NULL
)
SELECT 
    Faixa_Nota, 
    COUNT(*) AS Qtd_Candidatos
FROM FaixasRedacao
GROUP BY Faixa_Nota
ORDER BY Faixa_Nota;

-- Análise dos Motivos de Nota Zero ou Problemas na Redação

SELECT 
    CASE p.COD_SIT_RED
        WHEN 1 THEN 'Sem problemas'
        WHEN 2 THEN 'Anulada'
        WHEN 3 THEN 'Cópia Texto Motivador'
        WHEN 4 THEN 'Em Branco'
        WHEN 6 THEN 'Fuga ao Tema'
        WHEN 7 THEN 'Não atendimento ao tipo textual'
        WHEN 8 THEN 'Texto insuficiente'
        WHEN 9 THEN 'Parte desconectada'
        ELSE 'Outros'
    END AS Situacao_Redacao,
    COUNT(*) AS Total_Candidatos
FROM dw.FAT_DES f
JOIN dw.DIM_PRV p ON f.PRV_SRK = p.PRV_SRK
WHERE f.IND_PRE_LIN = 1 
GROUP BY p.COD_SIT_RED
ORDER BY Total_Candidatos DESC;
