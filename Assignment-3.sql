-- Drop the database if it already exists
DROP DATABASE IF EXISTS ExerciseDb;

-------------------Part-1-----------------------------------------

-- Create the database
CREATE DATABASE ExerciseDb;

-- Use the database
USE ExerciseDb;

-- Create the Companylnfo table
CREATE TABLE  Companylnfo (
    Cld INT PRIMARY KEY,
    CName NVARCHAR(50) NOT NULL
);

-- Insert data into Companylnfo table
INSERT INTO Companylnfo (Cld, CName) VALUES
    (1, 'SamSung'),
    (2, 'HP'),
    (3, 'Apple'),
    (4, 'Dell'),
    (5, 'Toshiba'),
    (6, 'Redmi');

	select * from Companylnfo

-- Create the Productlnfo table
CREATE TABLE Productlnfo (
    Pld INT PRIMARY KEY,
    PName NVARCHAR(50) NOT NULL,
    PPrice FLOAT NOT NULL,
    PMDate DATE NOT NULL,
    Cld INT,
    FOREIGN KEY (Cld) REFERENCES Companylnfo (Cld)
);

-- Insert data into Productlnfo table
INSERT INTO Productlnfo (Pld, PName, PPrice, PMDate, Cld) VALUES
    (101, 'Laptop', 55000.90, '2023-12-12', 1),
    (102, 'Laptop', 35000.90, '2012-12-12', 2),
    (103, 'Mobile', 15000.90, '2012-03-12', 2),
    (104, 'Laptop', 135000.90, '2012-12-12', 3),
    (105, 'Mobile', 65000.90, '2012-12-12', 3),
    (106, 'Laptop', 35000.90, '2012-12-12', 5),
    (107, 'Mobile', 35000.90, '2012-01-12', 5),
    (108, 'Earpod', 1000.90, '2022-01-12', 3),
    (109, 'Laptop', 85000.90, '2021-12-12', 6),
    (110, 'Mobile', 55000.70, '2020-12-12', 1);

	select * from Productlnfo

-- Q1: Show All Companies Name and their products detail
SELECT CName, PName, PPrice, PMDate
FROM Companylnfo
JOIN Productlnfo ON Companylnfo.Cld = Productlnfo.Cld;

-- Q2: Show All Products Name and their respective company Name
SELECT PName, CName
FROM Productlnfo
JOIN Companylnfo ON Productlnfo.Cld = Companylnfo.Cld;

-- Q3: Show all possible combinations of company and products
SELECT CName, PName
FROM Companylnfo
CROSS JOIN Productlnfo;

---------------PART-2-------------------------------------


-- Create the Products table with FLOAT data type for PPrice and Discount
CREATE TABLE Products (
    Pld INT PRIMARY KEY,
    PQ INT NOT NULL,
    PPrice FLOAT NOT NULL,
    Discount FLOAT NOT NULL
);

-- Insert 3 records into the Products table
INSERT INTO Products (Pld, PQ, PPrice, Discount) VALUES
    (1, 5, 1000.50, 20.00),
    (2, 10, 350.50, 15.00),
    (3, 2, 220.00, 10.00);

	drop table Products

-- Create a function to calculate discounted value
CREATE FUNCTION CalculateDiscountedValue(@price FLOAT, @discount FLOAT) RETURNS FLOAT
AS
BEGIN
    DECLARE @discounted_value FLOAT;
    SET @discounted_value = @price - (@price * @discount / 100);
    RETURN @discounted_value;
END;
DROP FUNCTION IF EXISTS CalculateDiscountedValue;

-- Show PID, Price, Discount, and Price after Discount using the function
SELECT
    Pld AS PID,
    PPrice AS Price,
    Discount,
    dbo.CalculateDiscountedValue(PPrice, Discount) AS PriceAfterDiscount
FROM Products;
