# Diagrama do Banco de Dados

## Sistema de Gerenciamento de Clínica de Saúde

### Entidades

- ESPECIALIDADES
  - id_especialidade (PK)
  - nome

- PROFISSIONAIS
  - id_profissional (PK)
  - nome
  - registro_profissional
  - telefone
  - email
  - id_especialidade (FK)

- PACIENTES
  - id_paciente (PK)
  - nome
  - cpf
  - data_nascimento
  - telefone
  - email

- CONSULTAS
  - id_consulta (PK)
  - data_hora
  - status
  - id_paciente (FK)
  - id_profissional (FK)

- PRONTUÁRIOS
  - id_prontuario (PK)
  - id_paciente (FK)
  - data_registro
  - descricao

- PAGAMENTOS
  - id_pagamento (PK)
  - id_consulta (FK)
  - valor
  - forma_pagamento
  - status

### Relacionamentos

- Especialidades 1:N Profissionais
- Profissionais 1:N Consultas
- Pacientes 1:N Consultas
- Pacientes 1:N Prontuários
- Consultas 1:N Pagamentos
