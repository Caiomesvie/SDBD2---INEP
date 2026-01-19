CREATE SCHEMA IF NOT EXISTS silver;

COMMENT ON SCHEMA silver IS 'Camada silver - Dados Tratados vindo da base CSV';

DROP TABLE IF EXISTS silver.microdados_enem CASCADE;

CREATE TABLE silver.microdados_enem (
    NU_INSCRICAO BIGINT PRIMARY KEY,
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
    TX_RESPOSTAS_CN VARCHAR(50),
    TX_RESPOSTAS_CH VARCHAR(50),
    TX_RESPOSTAS_LC VARCHAR(50),
    TX_RESPOSTAS_MT VARCHAR(50),
    TP_LINGUA INTEGER,
    TX_GABARITO_CN VARCHAR(50),
    TX_GABARITO_CH VARCHAR(50),
    TX_GABARITO_LC VARCHAR(50),
    TX_GABARITO_MT VARCHAR(50),
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

-- DADOS DO PARTICIPANTE

COMMENT ON COLUMN silver.microdados_enem.NU_INSCRICAO IS 'Número de inscrição';
COMMENT ON COLUMN silver.microdados_enem.TP_FAIXA_ETARIA IS 'Faixa etária';
COMMENT ON COLUMN silver.microdados_enem.TP_SEXO IS 'Sexo';
COMMENT ON COLUMN silver.microdados_enem.TP_ESTADO_CIVIL IS 'Estado Civil';
COMMENT ON COLUMN silver.microdados_enem.TP_COR_RACA IS 'Cor/raça';
COMMENT ON COLUMN silver.microdados_enem.TP_NACIONALIDADE IS 'Nacionalidade';
COMMENT ON COLUMN silver.microdados_enem.TP_ST_CONCLUSAO IS 'Situação de conclusão do Ensino Médio';
COMMENT ON COLUMN silver.microdados_enem.TP_ANO_CONCLUIU IS 'Ano de Conclusão do Ensino Médio';
COMMENT ON COLUMN silver.microdados_enem.TP_ESCOLA IS 'Tipo de escola do Ensino Médio';
COMMENT ON COLUMN silver.microdados_enem.TP_ENSINO IS 'Tipo de instituição que concluiu ou concluirá o Ensino Médio';
COMMENT ON COLUMN silver.microdados_enem.IN_TREINEIRO IS 'Indica se o inscrito fez a prova com intuito de apenas treinar seus conhecimentos';

-- DADOS DA ESCOLA
COMMENT ON COLUMN silver.microdados_enem.CO_MUNICIPIO_ESC IS 'Código do município da escola';
COMMENT ON COLUMN silver.microdados_enem.NO_MUNICIPIO_ESC IS 'Nome do município da escola';
COMMENT ON COLUMN silver.microdados_enem.CO_UF_ESC IS 'Código da Unidade da Federação da escola';
COMMENT ON COLUMN silver.microdados_enem.TP_DEPENDENCIA_ADM_ESC IS 'Dependência administrativa (Escola)';
COMMENT ON COLUMN silver.microdados_enem.TP_LOCALIZACAO_ESC IS 'Localização (Escola)';
COMMENT ON COLUMN silver.microdados_enem.TP_SIT_FUNC_ESC IS 'Situação de funcionamento (Escola)';

-- DADOS DO LOCAL DE APLICAÇÃO
COMMENT ON COLUMN silver.microdados_enem.CO_MUNICIPIO_PROVA IS 'Código do município da aplicação da prova';
COMMENT ON COLUMN silver.microdados_enem.NO_MUNICIPIO_PROVA IS 'Nome do município da aplicação da prova';
COMMENT ON COLUMN silver.microdados_enem.CO_UF_PROVA IS 'Código da Unidade da Federação da aplicação da prova';
COMMENT ON COLUMN silver.microdados_enem.SG_UF_PROVA IS 'Sigla da Unidade da Federação da aplicação da prova';

-- PROVAS E GABARITOS
COMMENT ON COLUMN silver.microdados_enem.TP_PRESENCA_CN IS 'Presença na prova objetiva de Ciências da Natureza';
COMMENT ON COLUMN silver.microdados_enem.TP_PRESENCA_CH IS 'Presença na prova objetiva de Ciências Humanas';
COMMENT ON COLUMN silver.microdados_enem.TP_PRESENCA_LC IS 'Presença na prova objetiva de Linguagens e Códigos';
COMMENT ON COLUMN silver.microdados_enem.TP_PRESENCA_MT IS 'Presença na prova objetiva de Matemática';
COMMENT ON COLUMN silver.microdados_enem.CO_PROVA_CN IS 'Código do tipo de prova de Ciências da Natureza';
COMMENT ON COLUMN silver.microdados_enem.CO_PROVA_CH IS 'Código do tipo de prova de Ciências Humanas';
COMMENT ON COLUMN silver.microdados_enem.CO_PROVA_LC IS 'Código do tipo de prova de Linguagens e Códigos';
COMMENT ON COLUMN silver.microdados_enem.CO_PROVA_MT IS 'Código do tipo de prova de Matemática';
COMMENT ON COLUMN silver.microdados_enem.NU_NOTA_CN IS 'Nota da prova de Ciências da Natureza';
COMMENT ON COLUMN silver.microdados_enem.NU_NOTA_CH IS 'Nota da prova de Ciências Humanas';
COMMENT ON COLUMN silver.microdados_enem.NU_NOTA_LC IS 'Nota da prova de Linguagens e Códigos';
COMMENT ON COLUMN silver.microdados_enem.NU_NOTA_MT IS 'Nota da prova de Matemática';
COMMENT ON COLUMN silver.microdados_enem.TX_RESPOSTAS_CN IS 'Vetor com as respostas da parte objetiva da prova de Ciências da Natureza';
COMMENT ON COLUMN silver.microdados_enem.TX_RESPOSTAS_CH IS 'Vetor com as respostas da parte objetiva da prova de Ciências Humanas';
COMMENT ON COLUMN silver.microdados_enem.TX_RESPOSTAS_LC IS 'Vetor com as respostas da parte objetiva da prova de Linguagens e Códigos';
COMMENT ON COLUMN silver.microdados_enem.TX_RESPOSTAS_MT IS 'Vetor com as respostas da parte objetiva da prova de Matemática';
COMMENT ON COLUMN silver.microdados_enem.TP_LINGUA IS 'Língua Estrangeira';
COMMENT ON COLUMN silver.microdados_enem.TX_GABARITO_CN IS 'Vetor com o gabarito da parte objetiva da prova de Ciências da Natureza';
COMMENT ON COLUMN silver.microdados_enem.TX_GABARITO_CH IS 'Vetor com o gabarito da parte objetiva da prova de Ciências Humanas';
COMMENT ON COLUMN silver.microdados_enem.TX_GABARITO_LC IS 'Vetor com o gabarito da parte objetiva da prova de Linguagens e Códigos';
COMMENT ON COLUMN silver.microdados_enem.TX_GABARITO_MT IS 'Vetor com o gabarito da parte objetiva da prova de Matemática';

-- REDAÇÃO
COMMENT ON COLUMN silver.microdados_enem.TP_STATUS_REDACAO IS 'Situação da redação do participante';
COMMENT ON COLUMN silver.microdados_enem.NU_NOTA_COMP1 IS 'Nota da competência 1 - Demonstrar domínio da modalidade escrita formal';
COMMENT ON COLUMN silver.microdados_enem.NU_NOTA_COMP2 IS 'Nota da competência 2 - Compreender a proposta de redação e aplicar conceitos';
COMMENT ON COLUMN silver.microdados_enem.NU_NOTA_COMP3 IS 'Nota da competência 3 - Selecionar, relacionar, organizar e interpretar informações';
COMMENT ON COLUMN silver.microdados_enem.NU_NOTA_COMP4 IS 'Nota da competência 4 - Demonstrar conhecimento dos mecanismos linguísticos';
COMMENT ON COLUMN silver.microdados_enem.NU_NOTA_COMP5 IS 'Nota da competência 5 - Elaborar proposta de intervenção para o problema';
COMMENT ON COLUMN silver.microdados_enem.NU_NOTA_REDACAO IS 'Nota da prova de redação';

-- QUESTIONÁRIO SOCIOECONÔMICO
COMMENT ON COLUMN silver.microdados_enem.Q001 IS 'Até que série seu pai, ou o homem responsável por você, estudou?';
COMMENT ON COLUMN silver.microdados_enem.Q002 IS 'Até que série sua mãe, ou a mulher responsável por você, estudou?';
COMMENT ON COLUMN silver.microdados_enem.Q003 IS 'Grupo de ocupação do pai ou homem responsável';
COMMENT ON COLUMN silver.microdados_enem.Q004 IS 'Grupo de ocupação da mãe ou mulher responsável';
COMMENT ON COLUMN silver.microdados_enem.Q005 IS 'Incluindo você, quantas pessoas moram atualmente em sua residência?';
COMMENT ON COLUMN silver.microdados_enem.Q006 IS 'Qual é a renda mensal de sua família?';
COMMENT ON COLUMN silver.microdados_enem.Q007 IS 'Em sua residência trabalha empregado(a) doméstico(a)?';
COMMENT ON COLUMN silver.microdados_enem.Q008 IS 'Na sua residência tem banheiro?';
COMMENT ON COLUMN silver.microdados_enem.Q009 IS 'Na sua residência tem quartos para dormir?';
COMMENT ON COLUMN silver.microdados_enem.Q010 IS 'Na sua residência tem carro?';
COMMENT ON COLUMN silver.microdados_enem.Q011 IS 'Na sua residência tem motocicleta?';
COMMENT ON COLUMN silver.microdados_enem.Q012 IS 'Na sua residência tem geladeira?';
COMMENT ON COLUMN silver.microdados_enem.Q013 IS 'Na sua residência tem freezer?';
COMMENT ON COLUMN silver.microdados_enem.Q014 IS 'Na sua residência tem máquina de lavar roupa?';
COMMENT ON COLUMN silver.microdados_enem.Q015 IS 'Na sua residência tem máquina de secar roupa?';
COMMENT ON COLUMN silver.microdados_enem.Q016 IS 'Na sua residência tem forno micro-ondas?';
COMMENT ON COLUMN silver.microdados_enem.Q017 IS 'Na sua residência tem máquina de lavar louça?';
COMMENT ON COLUMN silver.microdados_enem.Q018 IS 'Na sua residência tem aspirador de pó?';
COMMENT ON COLUMN silver.microdados_enem.Q019 IS 'Na sua residência tem televisão em cores?';
COMMENT ON COLUMN silver.microdados_enem.Q020 IS 'Na sua residência tem aparelho de DVD?';
COMMENT ON COLUMN silver.microdados_enem.Q021 IS 'Na sua residência tem TV por assinatura?';
COMMENT ON COLUMN silver.microdados_enem.Q022 IS 'Na sua residência tem telefone celular?';
COMMENT ON COLUMN silver.microdados_enem.Q023 IS 'Na sua residência tem telefone fixo?';
COMMENT ON COLUMN silver.microdados_enem.Q024 IS 'Na sua residência tem computador?';
COMMENT ON COLUMN silver.microdados_enem.Q025 IS 'Na sua residência tem acesso à Internet?';