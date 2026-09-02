CREATE DATABASE clinica_saude;

USE clinica_saude;

-- ==========================================
-- TABELA DE ESPECIALIDADES
-- ==========================================

CREATE TABLE especialidades (
    id_especialidade INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE
);

-- ==========================================
-- TABELA DE PROFISSIONAIS
-- ==========================================

CREATE TABLE profissionais (
    id_profissional INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    registro_profissional VARCHAR(30) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(150) UNIQUE,
    id_especialidade INT NOT NULL,

    FOREIGN KEY (id_especialidade)
        REFERENCES especialidades(id_especialidade)
);

-- ==========================================
-- TABELA DE PACIENTES
-- ==========================================

CREATE TABLE pacientes (
    id_paciente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(150) UNIQUE
);

-- ==========================================
-- TABELA DE CONSULTAS
-- ==========================================

CREATE TABLE consultas (
    id_consulta INT PRIMARY KEY AUTO_INCREMENT,
    data_hora DATETIME NOT NULL,

    status ENUM(
        'Agendada',
        'Realizada',
        'Cancelada'
    ) NOT NULL DEFAULT 'Agendada',

    id_paciente INT NOT NULL,
    id_profissional INT NOT NULL,

    FOREIGN KEY (id_paciente)
        REFERENCES pacientes(id_paciente),

    FOREIGN KEY (id_profissional)
        REFERENCES profissionais(id_profissional)
);

-- ==========================================
-- TABELA DE PRONTUÁRIOS
-- ==========================================

CREATE TABLE prontuarios (
    id_prontuario INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    data_registro DATE NOT NULL,
    descricao TEXT NOT NULL,

    FOREIGN KEY (id_paciente)
        REFERENCES pacientes(id_paciente)
);

-- ==========================================
-- TABELA DE PAGAMENTOS
-- ==========================================

CREATE TABLE pagamentos (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_consulta INT NOT NULL,

    valor DECIMAL(10,2) NOT NULL
        CHECK (valor >= 0),

    forma_pagamento ENUM(
        'Pix',
        'Cartao',
        'Dinheiro'
    ) NOT NULL,

    status ENUM(
        'Pendente',
        'Pago',
        'Cancelado'
    ) NOT NULL DEFAULT 'Pendente',

    FOREIGN KEY (id_consulta)
        REFERENCES consultas(id_consulta)
);

-- ==========================================
-- INSERÇÃO DE ESPECIALIDADES
-- ==========================================

INSERT INTO especialidades (nome) VALUES
('Clínica Geral'),
('Pediatria'),
('Dermatologia');

-- ==========================================
-- INSERÇÃO DE PROFISSIONAIS
-- ==========================================

INSERT INTO profissionais
(nome, registro_profissional, telefone, email, id_especialidade)
VALUES
(
    'Ana Paula Mendes',
    'CRM-10001',
    '(69) 99999-1111',
    'ana@clinicasaude.com',
    1
),
(
    'Carlos Henrique Souza',
    'CRM-10002',
    '(69) 99999-2222',
    'carlos@clinicasaude.com',
    2
),
(
    'Mariana Alves Lima',
    'CRM-10003',
    '(69) 99999-3333',
    'mariana@clinicasaude.com',
    3
);

-- ==========================================
-- INSERÇÃO DE PACIENTES
-- ==========================================

INSERT INTO pacientes
(nome, cpf, data_nascimento, telefone, email)
VALUES
(
    'João da Silva',
    '111.111.111-11',
    '1995-04-12',
    '(69) 98888-1111',
    'joao@email.com'
),
(
    'Maria Oliveira',
    '222.222.222-22',
    '1988-09-25',
    '(69) 98888-2222',
    'maria@email.com'
),
(
    'Pedro Santos',
    '333.333.333-33',
    '2014-02-10',
    '(69) 98888-3333',
    'pedro@email.com'
);

-- ==========================================
-- INSERÇÃO DE CONSULTAS
-- ==========================================

INSERT INTO consultas
(data_hora, status, id_paciente, id_profissional)
VALUES
(
    '2026-09-10 08:00:00',
    'Agendada',
    1,
    1
),
(
    '2026-09-10 09:00:00',
    'Agendada',
    2,
    3
),
(
    '2026-09-11 14:00:00',
    'Realizada',
    3,
    2
);

-- ==========================================
-- INSERÇÃO DE PRONTUÁRIOS
-- ==========================================

INSERT INTO prontuarios
(id_paciente, data_registro, descricao)
VALUES
(
    1,
    '2026-09-10',
    'Consulta de rotina.'
),
(
    2,
    '2026-09-10',
    'Avaliação dermatológica.'
),
(
    3,
    '2026-09-11',
    'Acompanhamento pediátrico.'
);

-- ==========================================
-- INSERÇÃO DE PAGAMENTOS
-- ==========================================

INSERT INTO pagamentos
(id_consulta, valor, forma_pagamento, status)
VALUES
(
    1,
    180.00,
    'Pix',
    'Pendente'
),
(
    2,
    220.00,
    'Cartao',
    'Pago'
),
(
    3,
    160.00,
    'Dinheiro',
    'Pago'
);

-- ==========================================
-- UPDATE
-- ==========================================

UPDATE pacientes
SET telefone = '(69) 98888-9999'
WHERE id_paciente = 1;

-- ==========================================
-- DELETE
-- ==========================================

DELETE FROM pagamentos
WHERE id_pagamento = 1;

-- ==========================================
-- SELECT - TODOS OS PACIENTES
-- ==========================================

SELECT *
FROM pacientes;

-- ==========================================
-- SELECT - CONSULTAS COMPLETAS
-- ==========================================

SELECT
    c.id_consulta,
    c.data_hora,
    c.status,
    p.nome AS paciente,
    pr.nome AS profissional,
    e.nome AS especialidade

FROM consultas c

JOIN pacientes p
    ON p.id_paciente = c.id_paciente

JOIN profissionais pr
    ON pr.id_profissional = c.id_profissional

JOIN especialidades e
    ON e.id_especialidade = pr.id_especialidade

ORDER BY c.data_hora;

-- ==========================================
-- SELECT - CONSULTAS POR PROFISSIONAL
-- ==========================================

SELECT
    pr.nome AS profissional,
    COUNT(c.id_consulta) AS total_consultas

FROM profissionais pr

LEFT JOIN consultas c
    ON c.id_profissional = pr.id_profissional

GROUP BY
    pr.id_profissional,
    pr.nome

ORDER BY total_consultas DESC;
