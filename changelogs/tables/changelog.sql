--liquibase formatted sql

--changeset asmith:createTable-001
CREATE TABLE my_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

--changeset asmith:grant-001
GRANT USAGE ON SCHEMA public TO postgres;