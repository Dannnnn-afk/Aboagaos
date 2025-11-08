-- Create database
--CREATE DATABASE IF NOT EXISTS aboagaos_db;

--USE aboagaos_db;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  age INT,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO users (name, email, age) VALUES
  ('Juan Pérez', 'juan@example.com', 30),
  ('María García', 'maria@example.com', 25),
  ('Carlos López', 'carlos@example.com', 35);


--ayuda