CREATE SCHEMA IF NOT EXISTS silver;

COMMENT ON SCHEMA silver IS 'Camada Silver - Dados Tratados vindo da base CSV';

DROP TABLE IF EXISTS silver.dados_INEP CASCADE;

CREATE TABLE silver.dados_INEP (
    NU_INSCRICAO BIGINT PRIMARY KEY,
    NU_ANO INTEGER,
    TP_FAIXA_ETARIA INTEGER,
    TP_SEXO VARCHAR(1),
    TP_ESTADO_CIVIL INTEGER,
    TP_COR_RACA INTEGER,
    TP_NACIONALIDADE INTEGER,
    TP_ST_CONCLUSAO INTEGER,
    TP_ANO_CONCLUIU INTEGER,
    TP_ESCOLA INTEGER,
    TP_ENSINO INTEGER,
    IN_TREINEIRO INTEGER,
    CO_MUNICIPIO_ESC INTEGER,
    NO_MUNICIPIO_ESC VARCHAR(150),
    CO_UF_ESC INTEGER,
    SG_UF_ESC VARCHAR(2),
    TP_DEPENDENCIA_ADM_ESC INTEGER,
    TP_LOCALIZACAO_ESC INTEGER,
    TP_SIT_FUNC_ESC INTEGER,
    CO_MUNICIPIO_PROVA INTEGER,
    NO_MUNICIPIO_PROVA VARCHAR(150),
    CO_UF_PROVA INTEGER,
    SG_UF_PROVA VARCHAR(2),
    TP_PRESENCA_CN INTEGER,
    TP_PRESENCA_CH INTEGER,
    TP_PRESENCA_LC INTEGER,
    TP_PRESENCA_MT INTEGER,
    CO_PROVA_CN INTEGER,
    CO_PROVA_CH INTEGER,
    CO_PROVA_LC INTEGER,
    CO_PROVA_MT INTEGER,
    NU_NOTA_CN NUMERIC(10,2),
    NU_NOTA_CH NUMERIC(10,2),
    NU_NOTA_LC NUMERIC(10,2),
    NU_NOTA_MT NUMERIC(10,2),
    TX_RESPOSTAS_CN VARCHAR(45),
    TX_RESPOSTAS_CH VARCHAR(45),
    TX_RESPOSTAS_LC VARCHAR(50),
    TX_RESPOSTAS_MT VARCHAR(45),
    TP_LINGUA INTEGER,
    TX_GABARITO_CN VARCHAR(45),
    TX_GABARITO_CH VARCHAR(45),
    TX_GABARITO_LC VARCHAR(50),
    TX_GABARITO_MT VARCHAR(45),
    TP_STATUS_REDACAO INTEGER,
    NU_NOTA_COMP1 NUMERIC(10,2),
    NU_NOTA_COMP2 NUMERIC(10,2),
    NU_NOTA_COMP3 NUMERIC(10,2),
    NU_NOTA_COMP4 NUMERIC(10,2),
    NU_NOTA_COMP5 NUMERIC(10,2),
    NU_NOTA_REDACAO NUMERIC(10,2),
    Q001 VARCHAR(1),
    Q002 VARCHAR(1),
    Q003 VARCHAR(1),
    Q004 VARCHAR(1),
    Q005 INTEGER,
    Q006 VARCHAR(1),
    Q007 VARCHAR(1),
    Q008 VARCHAR(1),
    Q009 VARCHAR(1),
    Q010 VARCHAR(1),
    Q011 VARCHAR(1),
    Q012 VARCHAR(1),
    Q013 VARCHAR(1),
    Q014 VARCHAR(1),
    Q015 VARCHAR(1),
    Q016 VARCHAR(1),
    Q017 VARCHAR(1),
    Q018 VARCHAR(1),
    Q019 VARCHAR(1),
    Q020 VARCHAR(1),
    Q021 VARCHAR(1),
    Q022 VARCHAR(1),
    Q023 VARCHAR(1),
    Q024 VARCHAR(1),
    Q025 VARCHAR(1)
);

--Comentários nas colunas 

COMMENT ON COLUMN silver.dados_INEP.NU_INSCRICAO IS 'Número de inscrição';
COMMENT ON COLUMN silver.dados_INEP.NU_ANO IS 'Ano do Enem';
COMMENT ON COLUMN silver.dados_INEP.TP_FAIXA_ETARIA IS 'Faixa etária';
COMMENT ON COLUMN silver.dados_INEP.TP_SEXO IS 'Sexo';
COMMENT ON COLUMN silver.dados_INEP.TP_ESTADO_CIVIL IS 'Estado Civil';
COMMENT ON COLUMN silver.dados_INEP.TP_COR_RACA IS 'Cor/raça';
COMMENT ON COLUMN silver.dados_INEP.TP_NACIONALIDADE IS 'Nacionalidade';
COMMENT ON COLUMN silver.dados_INEP.TP_ST_CONCLUSAO IS 'Situação de conclusão do Ensino Médio';
COMMENT ON COLUMN silver.dados_INEP.TP_ANO_CONCLUIU IS 'Ano de Conclusão do Ensino Médio';
COMMENT ON COLUMN silver.dados_INEP.TP_ESCOLA IS 'Tipo de escola do Ensino Médio';
COMMENT ON COLUMN silver.dados_INEP.TP_ENSINO IS 'Tipo de instituição que concluiu ou concluirá o Ensino Médio';
COMMENT ON COLUMN silver.dados_INEP.IN_TREINEIRO IS 'Indica se o inscrito fez a prova com intuito de apenas treinar seus conhecimentos';

-- DADOS DA ESCOLA
COMMENT ON COLUMN silver.dados_INEP.CO_MUNICIPIO_ESC IS 'Código do município da escola';
COMMENT ON COLUMN silver.dados_INEP.NO_MUNICIPIO_ESC IS 'Nome do município da escola';
COMMENT ON COLUMN silver.dados_INEP.CO_UF_ESC IS 'Código da Unidade da Federação da escola';
COMMENT ON COLUMN silver.dados_INEP.SG_UF_ESC IS 'Sigla da Unidade da Federação da escola';
COMMENT ON COLUMN silver.dados_INEP.TP_DEPENDENCIA_ADM_ESC IS 'Dependência administrativa (Escola)';
COMMENT ON COLUMN silver.dados_INEP.TP_LOCALIZACAO_ESC IS 'Localização (Escola)';
COMMENT ON COLUMN silver.dados_INEP.TP_SIT_FUNC_ESC IS 'Situação de funcionamento (Escola)';

-- DADOS DO LOCAL DE APLICAÇÃO
COMMENT ON COLUMN silver.dados_INEP.CO_MUNICIPIO_PROVA IS 'Código do município da aplicação da prova';
COMMENT ON COLUMN silver.dados_INEP.NO_MUNICIPIO_PROVA IS 'Nome do município da aplicação da prova';
COMMENT ON COLUMN silver.dados_INEP.CO_UF_PROVA IS 'Código da Unidade da Federação da aplicação da prova';
COMMENT ON COLUMN silver.dados_INEP.SG_UF_PROVA IS 'Sigla da Unidade da Federação da aplicação da prova';

-- PROVAS E GABARITOS
COMMENT ON COLUMN silver.dados_INEP.TP_PRESENCA_CN IS 'Presença na prova objetiva de Ciências da Natureza';
COMMENT ON COLUMN silver.dados_INEP.TP_PRESENCA_CH IS 'Presença na prova objetiva de Ciências Humanas';
COMMENT ON COLUMN silver.dados_INEP.TP_PRESENCA_LC IS 'Presença na prova objetiva de Linguagens e Códigos';
COMMENT ON COLUMN silver.dados_INEP.TP_PRESENCA_MT IS 'Presença na prova objetiva de Matemática';
COMMENT ON COLUMN silver.dados_INEP.CO_PROVA_CN IS 'Código do tipo de prova de Ciências da Natureza';
COMMENT ON COLUMN silver.dados_INEP.CO_PROVA_CH IS 'Código do tipo de prova de Ciências Humanas';
COMMENT ON COLUMN silver.dados_INEP.CO_PROVA_LC IS 'Código do tipo de prova de Linguagens e Códigos';
COMMENT ON COLUMN silver.dados_INEP.CO_PROVA_MT IS 'Código do tipo de prova de Matemática';
COMMENT ON COLUMN silver.dados_INEP.NU_NOTA_CN IS 'Nota da prova de Ciências da Natureza';
COMMENT ON COLUMN silver.dados_INEP.NU_NOTA_CH IS 'Nota da prova de Ciências Humanas';
COMMENT ON COLUMN silver.dados_INEP.NU_NOTA_LC IS 'Nota da prova de Linguagens e Códigos';
COMMENT ON COLUMN silver.dados_INEP.NU_NOTA_MT IS 'Nota da prova de Matemática';
COMMENT ON COLUMN silver.dados_INEP.TX_RESPOSTAS_CN IS 'Vetor com as respostas da parte objetiva da prova de Ciências da Natureza';
COMMENT ON COLUMN silver.dados_INEP.TX_RESPOSTAS_CH IS 'Vetor com as respostas da parte objetiva da prova de Ciências Humanas';
COMMENT ON COLUMN silver.dados_INEP.TX_RESPOSTAS_LC IS 'Vetor com as respostas da parte objetiva da prova de Linguagens e Códigos';
COMMENT ON COLUMN silver.dados_INEP.TX_RESPOSTAS_MT IS 'Vetor com as respostas da parte objetiva da prova de Matemática';
COMMENT ON COLUMN silver.dados_INEP.TP_LINGUA IS 'Língua Estrangeira';
COMMENT ON COLUMN silver.dados_INEP.TX_GABARITO_CN IS 'Vetor com o gabarito da parte objetiva da prova de Ciências da Natureza';
COMMENT ON COLUMN silver.dados_INEP.TX_GABARITO_CH IS 'Vetor com o gabarito da parte objetiva da prova de Ciências Humanas';
COMMENT ON COLUMN silver.dados_INEP.TX_GABARITO_LC IS 'Vetor com o gabarito da parte objetiva da prova de Linguagens e Códigos';
COMMENT ON COLUMN silver.dados_INEP.TX_GABARITO_MT IS 'Vetor com o gabarito da parte objetiva da prova de Matemática';

-- REDAÇÃO
COMMENT ON COLUMN silver.dados_INEP.TP_STATUS_REDACAO IS 'Situação da redação do participante';
COMMENT ON COLUMN silver.dados_INEP.NU_NOTA_COMP1 IS 'Nota da competência 1 - Demonstrar domínio da modalidade escrita formal';
COMMENT ON COLUMN silver.dados_INEP.NU_NOTA_COMP2 IS 'Nota da competência 2 - Compreender a proposta de redação e aplicar conceitos';
COMMENT ON COLUMN silver.dados_INEP.NU_NOTA_COMP3 IS 'Nota da competência 3 - Selecionar, relacionar, organizar e interpretar informações';
COMMENT ON COLUMN silver.dados_INEP.NU_NOTA_COMP4 IS 'Nota da competência 4 - Demonstrar conhecimento dos mecanismos linguísticos';
COMMENT ON COLUMN silver.dados_INEP.NU_NOTA_COMP5 IS 'Nota da competência 5 - Elaborar proposta de intervenção para o problema';
COMMENT ON COLUMN silver.dados_INEP.NU_NOTA_REDACAO IS 'Nota da prova de redação';

-- QUESTIONÁRIO SOCIOECONÓMICO
COMMENT ON COLUMN silver.dados_INEP.Q001 IS 'Até que série seu pai, ou o homem responsável por você, estudou?';
COMMENT ON COLUMN silver.dados_INEP.Q002 IS 'Até que série sua mãe, ou a mulher responsável por você, estudou?';
COMMENT ON COLUMN silver.dados_INEP.Q003 IS 'Grupo de ocupação do pai ou homem responsável';
COMMENT ON COLUMN silver.dados_INEP.Q004 IS 'Grupo de ocupação da mãe ou mulher responsável';
COMMENT ON COLUMN silver.dados_INEP.Q005 IS 'Incluindo você, quantas pessoas moram atualmente em sua residência?';
COMMENT ON COLUMN silver.dados_INEP.Q006 IS 'Qual é a renda mensal de sua família?';
COMMENT ON COLUMN silver.dados_INEP.Q007 IS 'Em sua residência trabalha empregado(a) doméstico(a)?';
COMMENT ON COLUMN silver.dados_INEP.Q008 IS 'Na sua residência tem banheiro?';
COMMENT ON COLUMN silver.dados_INEP.Q009 IS 'Na sua residência tem quartos para dormir?';
COMMENT ON COLUMN silver.dados_INEP.Q010 IS 'Na sua residência tem carro?';
COMMENT ON COLUMN silver.dados_INEP.Q011 IS 'Na sua residência tem motocicleta?';
COMMENT ON COLUMN silver.dados_INEP.Q012 IS 'Na sua residência tem geladeira?';
COMMENT ON COLUMN silver.dados_INEP.Q013 IS 'Na sua residência tem freezer?';
COMMENT ON COLUMN silver.dados_INEP.Q014 IS 'Na sua residência tem máquina de lavar roupa?';
COMMENT ON COLUMN silver.dados_INEP.Q015 IS 'Na sua residência tem máquina de secar roupa?';
COMMENT ON COLUMN silver.dados_INEP.Q016 IS 'Na sua residência tem forno micro-ondas?';
COMMENT ON COLUMN silver.dados_INEP.Q017 IS 'Na sua residência tem máquina de lavar louça?';
COMMENT ON COLUMN silver.dados_INEP.Q018 IS 'Na sua residência tem aspirador de pó?';
COMMENT ON COLUMN silver.dados_INEP.Q019 IS 'Na sua residência tem televisão em cores?';
COMMENT ON COLUMN silver.dados_INEP.Q020 IS 'Na sua residência tem aparelho de DVD?';
COMMENT ON COLUMN silver.dados_INEP.Q021 IS 'Na sua residência tem TV por assinatura?';
COMMENT ON COLUMN silver.dados_INEP.Q022 IS 'Na sua residência tem telefone celular?';
COMMENT ON COLUMN silver.dados_INEP.Q023 IS 'Na sua residência tem telefone fixo?';
COMMENT ON COLUMN silver.dados_INEP.Q024 IS 'Na sua residência tem computador?';
COMMENT ON COLUMN silver.dados_INEP.Q025 IS 'Na sua residência tem acesso à Internet?';