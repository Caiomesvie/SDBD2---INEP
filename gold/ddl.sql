CREATE SCHEMA IF NOT EXISTS gold;

COMMENT ON SCHEMA gold IS 'Camada Gold - Dados da silver para star schema';

DROP TABLE IF EXISTS gold.FAT_DES CASCADE;
DROP TABLE IF EXISTS gold.DIM_PRV CASCADE;
DROP TABLE IF EXISTS gold.DIM_SOC CASCADE;
DROP TABLE IF EXISTS gold.DIM_LOC CASCADE;
DROP TABLE IF EXISTS gold.DIM_PAR CASCADE;

CREATE TABLE DIM_PAR (
    PAR_SRK BIGINT PRIMARY KEY,
    NUM_INS BIGINT,
    NUM_ANO INTEGER,
    COD_FAI_ETA INTEGER,
    TIP_SEX CHAR(1),
    COD_EST_CIV INTEGER,
    COD_COR_RAC INTEGER,
    COD_NAC INTEGER,
    COD_SIT_CON INTEGER,
    NUM_ANO_CON INTEGER,
    IND_TRE INTEGER
);

CREATE TABLE DIM_LOC (
    LOC_SRK BIGINT PRIMARY KEY,
    COD_MUN INTEGER,
    NOM_MUN VARCHAR(150),
    SGL_EST CHAR(2),
    COD_EST INTEGER
);

CREATE TABLE DIM_SOC (
    SOC_SRK BIGINT PRIMARY KEY,
    COD_ESC_PAI CHAR(1),
    COD_ESC_MAE CHAR(1),
    COD_OCU_PAI CHAR(1),
    COD_OCU_MAE CHAR(1),
    QTD_PES_RES INTEGER,
    COD_REN_FAM CHAR(1),
    COD_EMP_DOM CHAR(1),
    COD_POS_BAN CHAR(1),
    COD_POS_QUA CHAR(1),
    COD_POS_CAR CHAR(1),
    COD_POS_MOT CHAR(1),
    COD_POS_GEL CHAR(1),
    COD_POS_FRE CHAR(1),
    COD_POS_LAV CHAR(1),
    COD_POS_SEC CHAR(1),
    COD_POS_MIC CHAR(1),
    COD_POS_LOU CHAR(1),
    COD_POS_ASP CHAR(1),
    COD_POS_TEL CHAR(1),
    COD_POS_DVD CHAR(1),
    COD_POS_TVA CHAR(1),
    COD_POS_CEL CHAR(1),
    COD_POS_FIX CHAR(1),
    COD_POS_COM CHAR(1),
    IND_ACE_INT CHAR(1)
);

CREATE TABLE DIM_PRV (
    PRV_SRK BIGINT PRIMARY KEY,
    TIP_LIN INTEGER,
    COD_PRV_NAT INTEGER,
    COD_PRV_HUM INTEGER,
    COD_PRV_LIN INTEGER,
    COD_PRV_MAT INTEGER,
    COD_SIT_RED INTEGER
);

CREATE TABLE FAT_DES (
    FAT_SRK BIGINT PRIMARY KEY,
    NUM_INS BIGINT,
    VAL_NOT_NAT NUMERIC(10,2),
    VAL_NOT_HUM NUMERIC(10,2),
    VAL_NOT_LIN NUMERIC(10,2),
    VAL_NOT_MAT NUMERIC(10,2),
    VAL_NOT_RED NUMERIC(10,2),
    IND_PRE_NAT INTEGER,
    IND_PRE_HUM INTEGER,
    IND_PRE_LIN INTEGER,
    IND_PRE_MAT INTEGER,
    PAR_SRK BIGINT,
    LOC_SRK BIGINT,
    SOC_SRK BIGINT,
    PRV_SRK BIGINT,
    FOREIGN KEY (PAR_SRK) REFERENCES DIM_PAR(PAR_SRK),
    FOREIGN KEY (LOC_SRK) REFERENCES DIM_LOC(LOC_SRK),
    FOREIGN KEY (SOC_SRK) REFERENCES DIM_SOC(SOC_SRK),
    FOREIGN KEY (PRV_SRK) REFERENCES DIM_PRV(PRV_SRK)
);

-- 1. COMENTÁRIOS DA TABELA DIM_PAR (PARTICIPANTE)
COMMENT ON COLUMN DIM_PAR.PAR_SRK IS 'Chave Primária Artificial (Surrogate Key) do Participante';
COMMENT ON COLUMN DIM_PAR.NUM_INS IS 'Número de Inscrição do participante no ENEM';
COMMENT ON COLUMN DIM_PAR.NUM_ANO IS 'Ano de realização do exame';
COMMENT ON COLUMN DIM_PAR.COD_FAI_ETA IS 'Código da faixa etária do participante';
COMMENT ON COLUMN DIM_PAR.TIP_SEX IS 'Sexo do participante (M/F)';
COMMENT ON COLUMN DIM_PAR.COD_EST_CIV IS 'Código do Estado Civil';
COMMENT ON COLUMN DIM_PAR.COD_COR_RAC IS 'Código da Cor/Raça';
COMMENT ON COLUMN DIM_PAR.COD_NAC IS 'Código da Nacionalidade';
COMMENT ON COLUMN DIM_PAR.COD_SIT_CON IS 'Situação de conclusão do Ensino Médio';
COMMENT ON COLUMN DIM_PAR.NUM_ANO_CON IS 'Ano de conclusão do Ensino Médio';
COMMENT ON COLUMN DIM_PAR.IND_TRE IS 'Indicador de Treineiro (1=Sim, 0=Não)';

-- 2. COMENTÁRIOS DA TABELA DIM_LOC (LOCALIZAÇÃO)
COMMENT ON COLUMN DIM_LOC.LOC_SRK IS 'Chave Primária Artificial (Surrogate Key) da Localização';
COMMENT ON COLUMN DIM_LOC.COD_MUN IS 'Código IBGE do Município de aplicação da prova';
COMMENT ON COLUMN DIM_LOC.NOM_MUN IS 'Nome do Município de aplicação da prova';
COMMENT ON COLUMN DIM_LOC.SGL_EST IS 'Sigla da Unidade da Federação (UF) da prova';
COMMENT ON COLUMN DIM_LOC.COD_EST IS 'Código da Unidade da Federação (UF) da prova';

-- 3. COMENTÁRIOS DA TABELA DIM_SOC (SOCIOECONÔMICO)
COMMENT ON COLUMN DIM_SOC.SOC_SRK IS 'Chave Primária Artificial (Surrogate Key) do Perfil Socioeconômico';
COMMENT ON COLUMN DIM_SOC.COD_ESC_PAI IS 'Q001: Até que série o pai estudou?';
COMMENT ON COLUMN DIM_SOC.COD_ESC_MAE IS 'Q002: Até que série a mãe estudou?';
COMMENT ON COLUMN DIM_SOC.COD_OCU_PAI IS 'Q003: Grupo de ocupação do pai/responsável';
COMMENT ON COLUMN DIM_SOC.COD_OCU_MAE IS 'Q004: Grupo de ocupação da mãe/responsável';
COMMENT ON COLUMN DIM_SOC.QTD_PES_RES IS 'Q005: Quantas pessoas moram na residência?';
COMMENT ON COLUMN DIM_SOC.COD_REN_FAM IS 'Q006: Faixa de renda mensal da família';
COMMENT ON COLUMN DIM_SOC.COD_EMP_DOM IS 'Q007: Trabalha empregado doméstico na residência?';
COMMENT ON COLUMN DIM_SOC.COD_POS_BAN IS 'Q008: Quantidade de banheiros na residência';
COMMENT ON COLUMN DIM_SOC.COD_POS_QUA IS 'Q009: Quantidade de quartos para dormir';
COMMENT ON COLUMN DIM_SOC.COD_POS_CAR IS 'Q010: Quantidade de carros na residência';
COMMENT ON COLUMN DIM_SOC.COD_POS_MOT IS 'Q011: Quantidade de motocicletas na residência';
COMMENT ON COLUMN DIM_SOC.COD_POS_GEL IS 'Q012: Quantidade de geladeiras na residência';
COMMENT ON COLUMN DIM_SOC.COD_POS_FRE IS 'Q013: Possui freezer independente?';
COMMENT ON COLUMN DIM_SOC.COD_POS_LAV IS 'Q014: Possui máquina de lavar roupa?';
COMMENT ON COLUMN DIM_SOC.COD_POS_SEC IS 'Q015: Possui máquina de secar roupa?';
COMMENT ON COLUMN DIM_SOC.COD_POS_MIC IS 'Q016: Possui forno micro-ondas?';
COMMENT ON COLUMN DIM_SOC.COD_POS_LOU IS 'Q017: Possui máquina de lavar louça?';
COMMENT ON COLUMN DIM_SOC.COD_POS_ASP IS 'Q018: Possui aspirador de pó?';
COMMENT ON COLUMN DIM_SOC.COD_POS_TEL IS 'Q019: Quantidade de televisões em cores';
COMMENT ON COLUMN DIM_SOC.COD_POS_DVD IS 'Q020: Possui aparelho de DVD?';
COMMENT ON COLUMN DIM_SOC.COD_POS_TVA IS 'Q021: Possui TV por assinatura?';
COMMENT ON COLUMN DIM_SOC.COD_POS_CEL IS 'Q022: Quantidade de telefones celulares';
COMMENT ON COLUMN DIM_SOC.COD_POS_FIX IS 'Q023: Possui telefone fixo?';
COMMENT ON COLUMN DIM_SOC.COD_POS_COM IS 'Q024: Quantidade de computadores';
COMMENT ON COLUMN DIM_SOC.IND_ACE_INT IS 'Q025: Possui acesso à Internet?';

-- 4. COMENTÁRIOS DA TABELA DIM_PRV (PROVA)
COMMENT ON COLUMN DIM_PRV.PRV_SRK IS 'Chave Primária Artificial (Surrogate Key) da Prova';
COMMENT ON COLUMN DIM_PRV.TIP_LIN IS 'Língua Estrangeira escolhida (Inglês/Espanhol)';
COMMENT ON COLUMN DIM_PRV.COD_PRV_NAT IS 'Código do caderno de prova de Ciências da Natureza';
COMMENT ON COLUMN DIM_PRV.COD_PRV_HUM IS 'Código do caderno de prova de Ciências Humanas';
COMMENT ON COLUMN DIM_PRV.COD_PRV_LIN IS 'Código do caderno de prova de Linguagens e Códigos';
COMMENT ON COLUMN DIM_PRV.COD_PRV_MAT IS 'Código do caderno de prova de Matemática';
COMMENT ON COLUMN DIM_PRV.COD_SIT_RED IS 'Situação/Status da redação (ex: Anulada, Em branco)';

-- 5. COMENTÁRIOS DA TABELA FAT_DES (DESEMPENHO)
COMMENT ON COLUMN FAT_DES.FAT_SRK IS 'Chave Primária Artificial (Surrogate Key) do Fato Desempenho';
COMMENT ON COLUMN FAT_DES.NUM_INS IS 'Número de Inscrição (Chave Natural para conferência)';
COMMENT ON COLUMN FAT_DES.VAL_NOT_NAT IS 'Nota da prova de Ciências da Natureza';
COMMENT ON COLUMN FAT_DES.VAL_NOT_HUM IS 'Nota da prova de Ciências Humanas';
COMMENT ON COLUMN FAT_DES.VAL_NOT_LIN IS 'Nota da prova de Linguagens e Códigos';
COMMENT ON COLUMN FAT_DES.VAL_NOT_MAT IS 'Nota da prova de Matemática';
COMMENT ON COLUMN FAT_DES.VAL_NOT_RED IS 'Nota final da Redação';
COMMENT ON COLUMN FAT_DES.IND_PRE_NAT IS 'Indicador de Presença em Ciências da Natureza (1=Presente)';
COMMENT ON COLUMN FAT_DES.IND_PRE_HUM IS 'Indicador de Presença em Ciências Humanas (1=Presente)';
COMMENT ON COLUMN FAT_DES.IND_PRE_LIN IS 'Indicador de Presença em Linguagens (1=Presente)';
COMMENT ON COLUMN FAT_DES.IND_PRE_MAT IS 'Indicador de Presença em Matemática (1=Presente)';
COMMENT ON COLUMN FAT_DES.PAR_SRK IS 'Chave Estrangeira para Dimensão Participante';
COMMENT ON COLUMN FAT_DES.LOC_SRK IS 'Chave Estrangeira para Dimensão Localização';
COMMENT ON COLUMN FAT_DES.SOC_SRK IS 'Chave Estrangeira para Dimensão Socioeconômica';
COMMENT ON COLUMN FAT_DES.PRV_SRK IS 'Chave Estrangeira para Dimensão Prova';