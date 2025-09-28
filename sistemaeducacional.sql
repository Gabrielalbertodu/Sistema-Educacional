
CREATE DATABASE IF NOT EXISTS SistemaEducacional;
USE SistemaEducacional;

DROP TABLE IF EXISTS Nota, Matricula, Turma, Curso_Disciplina, Disciplina, Curso,
Funcionario, Professor_Telefone, Professor, Aluno_Telefone, Aluno, Usuario;

CREATE TABLE Usuario (
    IDUsuario INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF CHAR(11) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Tipo ENUM('Aluno', 'Professor', 'Funcionario') NOT NULL
);

CREATE TABLE Aluno (
    RA INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF CHAR(11) UNIQUE NOT NULL,
    Rua VARCHAR(100),
    Numero VARCHAR(10),
    Bairro VARCHAR(50),
    Cidade VARCHAR(50),
    DataNascimento DATE,
    IDUsuario INT UNIQUE,
    FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario)
);

CREATE TABLE Aluno_Telefone (
    RA INT,
    Telefone VARCHAR(15),
    PRIMARY KEY (RA, Telefone),
    FOREIGN KEY (RA) REFERENCES Aluno(RA)
);

CREATE TABLE Professor (
    IDProfessor INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF CHAR(11) UNIQUE NOT NULL,
    Formacao VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    IDUsuario INT UNIQUE,
    FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario)
);

CREATE TABLE Professor_Telefone (
    IDProfessor INT,
    Telefone VARCHAR(15),
    PRIMARY KEY (IDProfessor, Telefone),
    FOREIGN KEY (IDProfessor) REFERENCES Professor(IDProfessor)
);

CREATE TABLE Funcionario (
    IDFuncionario INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF CHAR(11) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE,
    IDUsuario INT UNIQUE,
    FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDUsuario)
);

CREATE TABLE Curso (
    IDCurso INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CargaHoraria INT NOT NULL,
    Modalidade ENUM('Presencial','EAD','Hibrido') NOT NULL
);

CREATE TABLE Disciplina (
    IDDisciplina INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CargaHoraria INT NOT NULL,
    Ementa TEXT
);

CREATE TABLE Curso_Disciplina (
    IDCurso INT,
    IDDisciplina INT,
    PRIMARY KEY (IDCurso, IDDisciplina),
    FOREIGN KEY (IDCurso) REFERENCES Curso(IDCurso),
    FOREIGN KEY (IDDisciplina) REFERENCES Disciplina(IDDisciplina)
);

CREATE TABLE Turma (
    IDTurma INT AUTO_INCREMENT,
    IDCurso INT,
    IDProfessor INT,
    IDDisciplina INT,
    Ano YEAR NOT NULL,
    Semestre ENUM('1','2') NOT NULL,
    Turno ENUM('Matutino','Vespertino','Noturno'),
    PRIMARY KEY (IDTurma, IDCurso),
    FOREIGN KEY (IDCurso) REFERENCES Curso(IDCurso),
    FOREIGN KEY (IDProfessor) REFERENCES Professor(IDProfessor),
    FOREIGN KEY (IDDisciplina) REFERENCES Disciplina(IDDisciplina)
);

CREATE TABLE Matricula (
    RA INT,
    IDTurma INT,
    IDCurso INT,
    DataMatricula DATE NOT NULL,
    PRIMARY KEY (RA, IDTurma, IDCurso),
    FOREIGN KEY (RA) REFERENCES Aluno(RA),
    FOREIGN KEY (IDTurma, IDCurso) REFERENCES Turma(IDTurma, IDCurso)
);

CREATE TABLE Nota (
    IDNota INT AUTO_INCREMENT,
    RA INT,
    IDTurma INT,
    IDCurso INT,
    Valor DECIMAL(5,2),
    Data DATE,
    PRIMARY KEY (IDNota, RA, IDTurma, IDCurso),
    FOREIGN KEY (RA) REFERENCES Aluno(RA),
    FOREIGN KEY (IDTurma, IDCurso) REFERENCES Turma(IDTurma, IDCurso)
);


INSERT INTO Usuario (Nome, CPF, Email, Tipo) VALUES
('João Silva', '12345678901', 'joao@teste.com', 'Aluno'),
('Ana Pereira', '23456789012', 'ana@teste.com', 'Aluno'),
('Carlos Lima', '34567890123', 'carlos@teste.com', 'Aluno'),
('Maria Souza', '98765432100', 'maria@teste.com', 'Professor'),
('Pedro Ramos', '87654321099', 'pedro@teste.com', 'Professor');

INSERT INTO Aluno (RA, Nome, CPF, Rua, Numero, Bairro, Cidade, DataNascimento, IDUsuario) VALUES
(101, 'João Silva', '12345678901', 'Rua A', '10', 'Centro', 'Brasília', '2000-05-10', 1),
(102, 'Ana Pereira', '23456789012', 'Rua B', '22', 'Asa Norte', 'Brasília', '2001-08-15', 2),
(103, 'Carlos Lima', '34567890123', 'Rua C', '33', 'Asa Sul', 'Brasília', '1999-02-20', 3);

INSERT INTO Aluno_Telefone VALUES 
(101, '61988887777'), (102, '61995554444'), (103, '61992223333');

INSERT INTO Professor (Nome, CPF, Formacao, Email, IDUsuario) VALUES
('Maria Souza', '98765432100', 'Mestrado em Computação', 'maria@teste.com', 4),
('Pedro Ramos', '87654321099', 'Doutorado em Engenharia', 'pedro@teste.com', 5);

INSERT INTO Professor_Telefone VALUES
(1, '61999996666'), (2, '61997775555');

INSERT INTO Curso (Nome, CargaHoraria, Modalidade) VALUES
('Engenharia de Software', 3200, 'Presencial'),
('Ciência da Computação', 3000, 'Hibrido');

INSERT INTO Disciplina (Nome, CargaHoraria, Ementa) VALUES
('Programação Orientada a Objetos', 80, 'POO com Java e UML.'),
('Banco de Dados', 60, 'Modelagem e SQL.'),
('Engenharia de Software I', 60, 'Processos e requisitos.');

INSERT INTO Curso_Disciplina VALUES
(1,1),(1,2),(1,3),(2,1),(2,2);

INSERT INTO Turma (IDCurso, IDProfessor, IDDisciplina, Ano, Semestre, Turno) VALUES
(1, 1, 1, 2025, '1', 'Matutino'),
(1, 2, 2, 2025, '1', 'Vespertino');

INSERT INTO Matricula VALUES
(101, 1, 1, '2025-02-10'),
(102, 1, 1, '2025-02-11'),
(103, 2, 1, '2025-02-12');

INSERT INTO Nota (RA, IDTurma, IDCurso, Valor, Data) VALUES
(101, 1, 1, 8.5, '2025-06-20'),
(102, 1, 1, 7.0, '2025-06-22'),
(103, 2, 1, 9.0, '2025-06-23');

UPDATE Aluno
SET Rua = 'Rua Nova A', Numero = '99', Bairro = 'Lago Sul'
WHERE RA = 101;

-- Atualizar nota do aluno Ana Pereira
UPDATE Nota
SET Valor = 8.0
WHERE RA = 102 AND IDTurma = 1 AND IDCurso = 1;

-- Trocar professor da turma 2
UPDATE Turma
SET IDProfessor = 1
WHERE IDTurma = 2 AND IDCurso = 1;

-- Listar turmas com curso, disciplina e professor
SELECT t.IDTurma, c.Nome AS Curso, d.Nome AS Disciplina, p.Nome AS Professor, t.Ano, t.Semestre, t.Turno
FROM Turma t
JOIN Curso c ON t.IDCurso = c.IDCurso
JOIN Disciplina d ON t.IDDisciplina = d.IDDisciplina
JOIN Professor p ON t.IDProfessor = p.IDProfessor;

-- Listar alunos matriculados em cada turma
SELECT t.IDTurma, a.RA, a.Nome AS Aluno, c.Nome AS Curso, d.Nome AS Disciplina
FROM Matricula m
JOIN Aluno a ON m.RA = a.RA
JOIN Turma t ON m.IDTurma = t.IDTurma AND m.IDCurso = t.IDCurso
JOIN Curso c ON t.IDCurso = c.IDCurso
JOIN Disciplina d ON t.IDDisciplina = d.IDDisciplina
ORDER BY t.IDTurma;

-- Histórico de notas
SELECT a.Nome AS Aluno, d.Nome AS Disciplina, n.Valor AS Nota, t.Ano, t.Semestre
FROM Nota n
JOIN Aluno a ON n.RA = a.RA
JOIN Turma t ON n.IDTurma = t.IDTurma AND n.IDCurso = t.IDCurso
JOIN Disciplina d ON t.IDDisciplina = d.IDDisciplina
ORDER BY a.Nome, t.Ano;
