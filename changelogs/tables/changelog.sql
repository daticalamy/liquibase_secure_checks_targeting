--liquibase formatted sql

--changeset asmith:createTable-001
CREATE TABLE my_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

--changeset asmith:grant-001
GRANT USAGE ON SCHEMA public TO postgres;

--changeset asmith:createTable-0001
CREATE TABLE my_table0001 (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

--changeset amy.smith labels:CDW-462736 contextFilter:PRD
insert into my_table0001 (name)
values ('Amy Smith');

--changeset amy.smith:truncate_001
truncate table my_table0001;

