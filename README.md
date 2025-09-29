#  Sistema Educacional – Banco de Dados

##  Descrição
Este projeto implementa um **sistema educacional** utilizando **MySQL**, com tabelas para gerenciar alunos, professores, funcionários, cursos, disciplinas, turmas, matrículas e notas.  
O script inclui **DDL (definição do esquema)**, **inserção de dados de exemplo**, **atualizações** e **consultas SQL**.

---

## Tecnologias Utilizadas
- **MySQL** 8.0+  
- Linguagem SQL (DDL, DML e DQL)

---

## Estrutura do Banco de Dados
As principais entidades do sistema são:

- **Usuário** → informações básicas (aluno, professor ou funcionário).  
- **Aluno / Aluno_Telefone** → cadastro de alunos e seus contatos.  
- **Professor / Professor_Telefone** → cadastro de professores e seus contatos.  
- **Funcionário** → funcionários administrativos.  
- **Curso** → cursos oferecidos pela instituição.  
- **Disciplina** → matérias vinculadas a cursos.  
- **Curso_Disciplina** → relação N:N entre cursos e disciplinas.  
- **Turma** → ligação entre curso, disciplina e professor, em determinado semestre.  
- **Matrícula** → registro do aluno em uma turma.  
- **Nota** → desempenho do aluno nas disciplinas.  

---

## Como Executar
1. Clone este repositório ou copie o script SQL.  
2. Abra o MySQL Workbench, DBeaver ou outro cliente SQL.  
3. Execute o script completo em um novo **schema**.  
   ```sql
   SOURCE sistema_educacional.sql;
