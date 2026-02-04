-- media por area de todos os municipios
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

-- verifica os 5 municípios com maior desvio padrão
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

-- maiores notas por prova e município
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

-- divisão de pessoas que escolheram linguagens
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

-- distribuição de Notas da Redação 
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

-- análise dos Motivos de Nota Zero ou Problemas na Redação
SELECT 
    CASE p.COD_SIT_RED
        WHEN 2 THEN 'Anulada'
        WHEN 3 THEN 'Cópia Texto Motivador'
        WHEN 4 THEN 'Em Branco'
        WHEN 6 THEN 'Fuga ao Tema'
        WHEN 7 THEN 'Não atendimento ao tipo textual'
        WHEN 8 THEN 'Texto insuficiente'
        WHEN 9 THEN 'Parte desconectada'
        ELSE 'Outros Motivos'
    END AS Situacao_Redacao,
    COUNT(*) AS Total_Candidatos
FROM dw.FAT_DES f
JOIN dw.DIM_PRV p ON f.PRV_SRK = p.PRV_SRK
WHERE f.IND_PRE_LIN = 1
  AND p.COD_SIT_RED <> 1 
GROUP BY Situacao_Redacao
ORDER BY Total_Candidatos DESC;

-- top 10 Municípios com melhores médias exclusivas de redação
SELECT 
    l.NOM_MUN AS Municipio,
    ROUND(AVG(f.VAL_NOT_RED), 2) AS Media_Redacao
FROM dw.FAT_DES f
JOIN dw.DIM_LOC l ON f.LOC_SRK = l.LOC_SRK
WHERE f.IND_PRE_LIN = 1 
  AND f.VAL_NOT_RED > 0
GROUP BY l.NOM_MUN
HAVING COUNT(*) > 50 -- para evitar municípios com pouco inscritos distorcerem a média
ORDER BY Media_Redacao DESC
LIMIT 10;

-- desempenho de notas por faixa de renda declarada
SELECT 
    CASE s.COD_REN_FAM
        WHEN 'A' THEN '01. Nenhuma Renda'
        WHEN 'B' THEN '02. Até R$ 1.100'
        WHEN 'C' THEN '03. R$ 1.100 - 1.650'
        WHEN 'D' THEN '04. R$ 1.650 - 2.200'
        WHEN 'E' THEN '05. R$ 2.200 - 2.750'
        WHEN 'F' THEN '06. R$ 2.750 - 3.300'
        WHEN 'G' THEN '07. R$ 3.300 - 4.400'
        WHEN 'H' THEN '08. R$ 4.400 - 5.500'
        WHEN 'I' THEN '09. R$ 5.500 - 6.600'
        WHEN 'J' THEN '10. R$ 6.600 - 7.700'
        WHEN 'K' THEN '11. R$ 7.700 - 8.800'
        WHEN 'L' THEN '12. R$ 8.800 - 9.900'
        WHEN 'M' THEN '13. R$ 9.900 - 11.000'
        WHEN 'N' THEN '14. R$ 11.000 - 13.200'
        WHEN 'O' THEN '15. R$ 13.200 - 16.500'
        WHEN 'P' THEN '16. R$ 16.500 - 22.000'
        WHEN 'Q' THEN '17. Acima de R$ 22.000'
        ELSE '18. Não Declarado'
    END AS Faixa_Renda,
    ROUND(AVG((VAL_NOT_NAT + VAL_NOT_HUM + VAL_NOT_LIN + VAL_NOT_MAT + VAL_NOT_RED) / 5), 2) AS Media_Geral,
    COUNT(*) AS Qtd_Candidatos
FROM dw.FAT_DES f
JOIN dw.DIM_SOC s ON f.SOC_SRK = s.SOC_SRK
WHERE IND_PRE_NAT = 1 AND IND_PRE_HUM = 1 AND IND_PRE_LIN = 1 AND IND_PRE_MAT = 1
GROUP BY s.COD_REN_FAM
ORDER BY s.COD_REN_FAM;

-- Perfil digital dos participantes
WITH PerfilTecnologico AS (
    SELECT 
        CASE 
            WHEN IND_ACE_INT = 'B' AND (COD_POS_COM = 'B' OR COD_POS_COM = 'C' OR COD_POS_COM = 'D' OR COD_POS_COM = 'E') THEN '1. Conectado (Internet + PC)'
            WHEN IND_ACE_INT = 'B' AND COD_POS_COM = 'A' THEN '2. Acesso Limitado (Só Internet, Sem PC)'
            WHEN IND_ACE_INT = 'A' AND (COD_POS_COM = 'B' OR COD_POS_COM = 'C' OR COD_POS_COM = 'D' OR COD_POS_COM = 'E') THEN '3. Offline com PC (Raro)'
            ELSE '4. Excluído Digital (Sem Internet, Sem PC)'
        END AS Status_Digital,
        (VAL_NOT_NAT + VAL_NOT_HUM + VAL_NOT_LIN + VAL_NOT_MAT + VAL_NOT_RED) / 5 AS Nota_Media
    FROM dw.FAT_DES f
    JOIN dw.DIM_SOC s ON f.SOC_SRK = s.SOC_SRK
    WHERE IND_PRE_NAT = 1 AND IND_PRE_HUM = 1 -- Filtra apenas presentes
)
SELECT 
    Status_Digital,
    ROUND(AVG(Nota_Media), 2) AS Media_Geral,
    COUNT(*) AS Total
FROM PerfilTecnologico
GROUP BY Status_Digital
ORDER BY Media_Geral DESC;

-- influencia da mobilidade nas notas 
SELECT 
    CASE 
        WHEN COD_POS_CAR <> 'A' AND COD_POS_MOT <> 'A' THEN 'Carro e Moto'
        WHEN COD_POS_CAR <> 'A' THEN 'Só Carro'
        WHEN COD_POS_MOT <> 'A' THEN 'Só Moto'
        ELSE 'Sem Veículo'
    END AS Perfil_Transporte,
    ROUND(AVG((VAL_NOT_NAT + VAL_NOT_HUM + VAL_NOT_LIN + VAL_NOT_MAT + VAL_NOT_RED) / 5), 2) AS Media_Geral
FROM dw.FAT_DES f
JOIN dw.DIM_SOC s ON f.SOC_SRK = s.SOC_SRK
WHERE IND_PRE_NAT = 1
GROUP BY 
    CASE 
        WHEN COD_POS_CAR <> 'A' AND COD_POS_MOT <> 'A' THEN 'Carro e Moto'
        WHEN COD_POS_CAR <> 'A' THEN 'Só Carro'
        WHEN COD_POS_MOT <> 'A' THEN 'Só Moto'
        ELSE 'Sem Veículo'
    END
ORDER BY Media_Geral DESC;

-- Influencia da mobilidade nas faltas

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
    CASE 
        WHEN s.POS_CAR <> 'A' OR s.POS_MOT <> 'A' THEN 'Possui Mobilidade (Carro/Moto)'
        ELSE 'Não Possui Mobilidade Própria'
    END AS Status_Mobilidade,
    COUNT(*) AS Total_Inscritos,
    SUM(c.foi_faltante) AS Qtd_Faltantes,
    ROUND(
        (SUM(c.foi_faltante) * 100.0) / COUNT(*), 
        2
    ) AS Percentual_Faltantes
FROM StatusCandidato c
JOIN dw.DIM_SOC s ON c.SOC_SRK = s.SOC_SRK
GROUP BY 
    CASE 
        WHEN s.POS_CAR <> 'A' OR s.POS_MOT <> 'A' THEN 'Possui Mobilidade (Carro/Moto)'
        ELSE 'Não Possui Mobilidade Própria'
    END
ORDER BY Percentual_Faltantes DESC;