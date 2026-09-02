# Diagrama do Banco de Dados

## Sistema de Gerenciamento de Clínica de Saúde

### Entidades e relacionamentos

ESPECIALIDADES
- id_especialidade (PK)
- nome

        1
        |
        | N
        ↓

PROFISSIONAIS
- id_profissional (PK)
- nome
- registro_profissional
- telefone
- email
- id_especialidade (FK)

        1
        |
        | N
        ↓

CONSULTAS
- id_consulta (PK)
- data_hora
- status
- id_paciente (FK)
- id_profissional (FK)

        |
        | 1
        ↓
PAGAMENTOS
- id_pagamento (PK)
- id_consulta (FK)
- valor
- forma_pagamento
- status


PACIENTES
- id_paciente (PK)
- nome
- cpf
- data_nascimento
- telefone
- email

        1
       / \
      /   \
     N     N
    ↓       ↓
CONSULTAS  PRONTUÁRIOS

PRONTUÁRIOS
- id_prontuario (PK)
- id_paciente (FK)
- data_registro
- descricao
