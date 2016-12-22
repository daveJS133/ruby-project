DROP TABLE users;
DROP TABLE accounts;
DROP TABLE transactions;

CREATE TABLE users(
id SERIAL PRIMARY KEY,
name VARCHAR(255),
total_income DECIMAL,
total_expenses DECIMAL,
total_balance DECIMAL
);


CREATE TABLE accounts(
id SERIAL4 PRIMARY KEY,
type VARCHAR(255),  
-- income DECIMAL,
-- expenses DECIMAL,
user_id INT4 references users(id)
-- balance DECIMAL
);

CREATE TABLE transactions(
id SERIAL4 PRIMARY KEY,
type VARCHAR(255),
merchant VARCHAR(255),
tag VARCHAR(255),
out VARCHAR(255),
amount DECIMAL,
account_id INT4 references accounts(id),
user_id INT4 references users(id)
);


