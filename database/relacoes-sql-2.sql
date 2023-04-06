-- Active: 1680731995567@@127.0.0.1@3306

-- Práticas

-- Prática 1 - cirando a tabela referenciada

CREATE TABLE users (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    create_at TEXT DEFAULT(DATETIME()) NOT NULL
);

INSERT INTO users(id, name, email, password) VALUES
("u001", "fulano", "fulano@email.com", "123456"),
("u002", "fulana", "fulana@email.com", "654321"),
("u003", "cicrano", "cicrano@email.com", "456321");

-- Prática 2 - criando a tabela de relações

CREATE TABLE follows (
    follower_id TEXT NOT NULL,
    followed_id TEXT NOT NULL,
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (followed_id) REFERENCES users(id)
);

INSERT INTO follows VALUES
("u001", "u002"),
("u001", "u003"),
("u002", "u001");

SELECT * FROM follows
INNER JOIN users
ON follows.follower_id = users.id;

-- Prática 3 - consultas mais complexas

SELECT * FROM follows
RIGHT JOIN users
ON follows.follower_id = users.id;

SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
LEFT JOIN users AS user
ON follows.followed_id = user.id;

-- vendo colunas especificas
SELECT 
    users.id,
    users.name,
    follows.followed_id,
    user.name
FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
LEFT JOIN users AS user
ON follows.followed_id = user.id;

-- Fixação
-- Relação de m:n
CREATE TABLE students(
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    last_name TEXT NOT NULL
);

CREATE TABLE classes (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL
);

INSERT INTO students VALUES
("s001", "Fulano", "Silva"),
("s002", "Fulana", "Santos"),
("s003", "Cicrano", "Silva"),
("s004", "Cicrana", "Santos");

INSERT INTO classes VALUES
("c001", "HTML", "Fundamentos"),
("c002", "CSS", "Fundamentos"),
("c003", "Java-Script", "Fundamentos"),
("c004", "REACT", "Fundamentos"),
("c005", "Type-Script", "Fundamentos");

-- Tabela de associação(relação)
CREATE TABLE registration (
   id TEXT PRIMARY KEY UNIQUE NOT NULL,
   student_id TEXT NOT NULL,
   class_id TEXT NOT NULL,
   FOREIGN KEY(student_id) REFERENCES students(id),
   FOREIGN KEY (class_id) REFERENCES classes(id)
);

INSERT INTO registration VALUES
("r001", "s001", "c001"),
("r002", "s001", "c002"),
("r003", "s001", "c003"),
("r004", "s002", "c004"),
("r005", "s003", "c004"),
("r006", "s003", "c005"),
("r007", "s004", "c003");

-- Todos os valores
SELECT * FROM registration
INNER JOIN students
ON students.id = student_id
INNER JOIN classes
ON classes.id = class_id;

-- Apenas id da matricula, nome do aluno e aula escolhida
SELECT registration.id AS Matriculas, students.name, classes.title  FROM registration
INNER JOIN students
ON students.id = student_id
INNER JOIN classes
ON classes.id = class_id;
