CREATE DATABASE ECommerce20;

USE ECommerce20;
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100)
);

CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100)
);

INSERT INTO Customer VALUES
(1, 'John'),
(2, 'Priya'),
(3, 'Rahul');

INSERT INTO Product VALUES
(101, 'Laptop'),
(102, 'Mobile'),
(103, 'Headphones');

CREATE TABLE Review (
    Review_ID VARCHAR(10) PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Rating INT NOT NULL,
    Review_Text VARCHAR(500),
    Review_Date DATE NOT NULL,
    CHECK (Rating BETWEEN 1 AND 5),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

INSERT INTO Review VALUES
('R101', 1, 101, 5, 'Excellent performance', '2026-11-01'),
('R102', 2, 102, 4, 'Good battery life', '2026-11-02'),
('R103', 3, 101, 3, 'Average product', '2026-11-03'),
('R104', 1, 103, 5, 'Very good quality', '2026-11-04'),
('R105', 2, 102, 2, 'Needs improvement', '2026-11-05'),
('R106', 3, 103, 4, 'Worth buying', '2026-11-06');

UPDATE Review
SET Review_Text = 'Excellent quality and performance'
WHERE Review_ID = 'R101';

DELETE FROM Review
WHERE Review_ID = 'R105';

SELECT Product.Product_Name, Review.Rating, Review.Review_Text
FROM Product
JOIN Review
ON Product.Product_ID = Review.Product_ID;

SELECT Customer.Customer_Name, Review.Review_Text, Review.Rating
FROM Customer
JOIN Review
ON Customer.Customer_ID = Review.Customer_ID;

SELECT Product.Product_Name, COUNT(Review.Review_ID) AS Total_Reviews
FROM Product
JOIN Review
ON Product.Product_ID = Review.Product_ID
GROUP BY Product.Product_ID, Product.Product_Name
ORDER BY Total_Reviews DESC;


SELECT *
FROM Review
ORDER BY Review_Date DESC;

SELECT *
FROM Review
WHERE Rating > 4;


SELECT Product.Product_Name, AVG(Review.Rating) AS Average_Rating
FROM Product
JOIN Review
ON Product.Product_ID = Review.Product_ID
GROUP BY Product.Product_ID, Product.Product_Name;


SELECT Product_ID, COUNT(Review_ID) AS Total_Reviews
FROM Review
GROUP BY Product_ID;

SELECT Product_ID, AVG(Rating) AS Average_Rating
FROM Review
GROUP BY Product_ID
HAVING AVG(Rating) = (
    SELECT MAX(Avg_Rating)
    FROM (
        SELECT AVG(Rating) AS Avg_Rating
        FROM Review
        GROUP BY Product_ID
    ) AS Ratings
);

SELECT Product_ID, AVG(Rating) AS Average_Rating
FROM Review
GROUP BY Product_ID
HAVING AVG(Rating) > 4;

SELECT
    Product.Product_Name,
    COUNT(Review.Review_ID) AS Total_Reviews,
    ROUND(AVG(Review.Rating), 2) AS Average_Rating
FROM Product
LEFT JOIN Review
ON Product.Product_ID = Review.Product_ID
GROUP BY Product.Product_ID, Product.Product_Name;

SELECT Product_ID, COUNT(*) AS Total_Reviews
FROM Review
GROUP BY Product_ID
ORDER BY Total_Reviews DESC;

SELECT Product_ID, AVG(Rating) AS Average_Rating
FROM Review
GROUP BY Product_ID
HAVING AVG(Rating) >= 4;

SELECT Product_ID, AVG(Rating) AS Average_Rating
FROM Review
GROUP BY Product_ID
HAVING AVG(Rating) < 3;

SELECT COUNT(*) AS Five_Star_Ratings
FROM Review
WHERE Rating = 5;

SELECT COUNT(*) AS Four_Star_Ratings
FROM Review
WHERE Rating = 4 ;


SELECT COUNT(*) AS Low_Rated_Reviews
FROM Review
WHERE Rating <= 2;

SELECT Rating, COUNT(*) AS Total
FROM Review
GROUP BY Rating
ORDER BY Rating DESC;

SELECT * FROM Review;

SELECT * FROM Customer;

SELECT * FROM Product;