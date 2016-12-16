DROP TABLE users;
DROP TABLE accounts;
DROP TABLE transactions;

CREATE TABLE users(
id SERIAL PRIMARY KEY,
name VARCHAR(255),
total_income MONEY,
total_expeses MONEY
);


CREATE TABLE accounts(
id SERIAL4 PRIMARY KEY,
type VARCHAR(255),
transactions SERIAL4 references transactions(id),
income MONEY,
expeses MONEY,
customer SERIAL4 references users(id)
);

CREATE TABLE transactions(
id SERIAL4 PRIMARY KEY,
type VARCHAR(255),
merchant VARCHAR(255),
tag VARCHAR(255),
out BOOLEAN

);


