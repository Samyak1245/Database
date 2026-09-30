CREATE DATABASE CT5;
USE CT5;
CREATE TABLE TB
(
	S_Name VARCHAR(50),
	Roll_No TINYINT PRIMARY KEY,
	Marks INT,
	Branch VARCHAR(20),
    Grade CHAR(1),
    Adderss VARCHAR(100) UNIQUE,
    Fees DOUBLE NOT NULL,
    CONSTRAINT Mark_Check check (Marks >= 0 AND Marks <= 100)
);

ALTER TABLE TB
MODIFY Grade CHAR(1),
MODIFY Marks FLOAT,
MODIFY Fees DOUBLE DEFAULT 12000;

ALTER TABLE CT
ADD COLUMN S_id INT UNIQUE;

ALTER TABLE TB
RENAME TO CT;

-- DROP TABLE TB;
DESCRIBE CT;

INSERT INTO CT (S_Name, Roll_No, Marks, Branch, Grade, Adderss, Fees, S_id)
VALUES
('Amit Sharma', 101, 85, 'CS', 'A', 'Mumbai', 75000, 01);

INSERT INTO CT (S_Name, Roll_No, Marks, Branch, Grade, Adderss, Fees, S_id)
VALUES
('Priya Patel', 102, 92, 'IT', 'O', 'Delhi', 78000, 02);

INSERT INTO CT (S_Name, Roll_No, Marks, Branch, Grade, Adderss, Fees, S_id)
VALUES
('Sneha Reddy', 104, 78, 'CS', 'B', 'Hyderabad', 75000, 04),
('Vikram Singh', 105, 89, 'ME', 'A', 'Pune', 68000, 05),
('Ananya Iyer', 106, 95, 'CS', 'O', 'Chennai', 75000, 06),
('Arjun Mehta', 107, 72, 'ME', 'B', 'Ahmedabad', 68000, 07),
('Kriti Deshmukh', 108, 81, 'IT', 'A', 'Nagpur', 78000, 08);

START TRANSACTION;
DELETE FROM CT
WHERE Roll_No = 101;
ROLLBACK;

UPDATE CT 
SET Branch = "CT"
WHERE Roll_No = 102;

SELECT * FROM CT;	

SELECT
	S_Name, Marks
FROM CT
WHERE Fees >50000
ORDER BY Marks DESC
LIMIT 3;

SELECT                   
Branch, 
sum(Fees) as Total
FROM CT
GROUP BY Branch;

SELECT 
AVG(Fees),
MAX(Fees),
MIN(Fees)
FROM CT;

SELECT 
	S_Name,
    Adderss
FROM CT 
WHERE Adderss != 'Nagpur';

SELECT 
	S_Name,
    Marks 
FROM CT
WHERE Marks + 10 > 100;

SELECT * FROM CT;	

CREATE VIEW Student_Marks AS
SELECT Roll_No, Marks, S_Name, Grade
FROM CT;

SELECT * FROM Student_Marks;


SELECT 
	S_Name, Marks
FROM Student_Marks
WHERE Marks > 88;

DROP VIEW Student_Marks;

SELECT *,
marks + 5 As `New Marks`
FROM CT;

SELECT *,
(Fees/2) AS `Half Fees`
FROM CT;


-- Not equals to
SELECT * FROM CT
WHERE NOT Branch = 'CS';

SELECT * FROM CT 
WHERE Branch <> 'CS';

SELECT * FROM CT
WHERE Branch != 'CS';

SELECT * FROM CT
WHERE Adderss = 'Mumbai' OR Adderss = 'Nagpur' OR Adderss = 'Pune';

SELECT * FROM CT
WHERE Adderss NOT IN ('Mumbai' , 'Nagpur' , 'Pune');

SELECT * FROM CT
WHERE Marks BETWEEN 85 AND 90;

SELECT * FROM CT
WHERE S_Name LIKE '_a%';

SELECT * FROM CT 
WHERE Grade IS NOT NULL;

-- Combine columns keeping only the first column name
SELECT Roll_No FROM CT
UNION -- increase rows
SELECT Adderss FROM CT;

-- JOIN Syntax (Cross Product)
SELECT 
CT.S_Name,
BT.Marks
FROM CT CT
JOIN CT BT;

SELECT 
	Branch, COUNT(Branch) 
FROM CT
GROUP BY Branch
HAVING MAX(Marks) >80 OR MIN(Fees) > 40000;

SELECT 
	Branch, COUNT(Branch) as `Student's Count`
FROM CT
GROUP BY Branch
HAVING SUM(Fees) BETWEEN 69000 AND 80000;

CREATE INDEX CTI
ON CT(S_Name);

SHOW INDEX FROM CT;

DROP INDEX CTI ON CT;

DROP INDEX S_id ON CT;

-- Cant drop the primary key as the index
DROP INDEX Roll_No ON CT;

-- Students whose marks are greater than the average marks
-- Subquery
SELECT S_Name FROM CT
WHERE Marks > (SELECT AVG(Marks) FROM CT);

-- Without Subquery (2 Select NOT CORRECT)
SELECT AVG(Marks) AS `Average Marks`
FROM CT;

SELECT S_Name FROM CT
WHERE Marks > 80;

SELECT S_Name FROM CT
WHERE Marks = (SELECT MAX(Marks) FROM CT);


SELECT S_Name, Branch, Marks FROM CT
WHERE Branch IN (SELECT Branch FROM CT WHERE Marks > 85);


CREATE TABLE FEES (
Roll_No TINYINT,
Paid_Fees FLOAT,
Payment_Status VARCHAR(20)
);

INSERT INTO FEES VALUES 
(101, 48000,'Paid'),
(102, 33000,'Pending'),
(104, 27000,'Paid'),
(105, 65000,'Pending'),
(106, 34000,'Paid');


ALTER TABLE FEES
RENAME TO F;

SELECT * FROM F;

SELECT
	CT.Roll_No,
    CT.S_Name,
    CT.Branch,
    F.Paid_Fees,
    F.Payment_Status
FROM CT  
LEFT JOIN F
ON CT.Roll_No = F.Roll_No

UNION

SELECT
	CT.Roll_No,
    CT.S_Name,
    CT.Branch,
    F.Paid_Fees,
    F.Payment_Status
FROM CT  
RIGHT JOIN F
ON CT.Roll_No = F.Roll_No;

SELECT
    CT.S_Name,
    F.Payment_Status
FROM CT  
CROSS JOIN F;
