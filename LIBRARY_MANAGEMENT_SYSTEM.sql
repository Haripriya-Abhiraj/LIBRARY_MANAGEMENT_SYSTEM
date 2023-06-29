CREATE DATABASE library;
USE library;

CREATE TABLE Branch(
Branch_no INT PRIMARY KEY ,
Manager_id INT ,
Branch_address VARCHAR(60),
Contact_no VARCHAR (10)
);


CREATE TABLE Employee(
Emp_id INT PRIMARY KEY ,
Emp_name VARCHAR(30),
Position VARCHAR (30),
Salary DECIMAL(8,2)
);

CREATE TABLE Coustomer(
Coustomer_id INT PRIMARY KEY,
Coustomer_name VARCHAR(30),
Coustomer_address VARCHAR(60),
Reg_date DATE
);

CREATE TABLE Books(
ISBN VARCHAR(30)PRIMARY KEY,
Book_title VARCHAR(40),
Categary VARCHAR(40),
Rental_price DECIMAL(8,2),
Status VARCHAR (5) ,
Author VARCHAR(30),
Publisher VARCHAR(40)
);




CREATE TABLE issue_status(
Issue_id INT PRIMARY KEY,
Issued_cust INT ,
Issued_book_name VARCHAR(50),
Issue_date DATE,
Isbn_book VARCHAR(40),
FOREIGN KEY(Issued_cust)REFERENCES Coustomer(Coustomer_id ),
FOREIGN KEY(Isbn_book )REFERENCES Books(Isbn) 
);

CREATE TABLE Returnstatus(
Return_id INT PRIMARY KEY ,
Return_cust INT,
Return_book_name VARCHAR(40),
Return_date DATE,
Isbn_book2 VARCHAR(30),
FOREIGN KEY(Isbn_book2 )REFERENCES Books(Isbn )
);


INSERT INTO Branch VALUES
(1,100,"Kozhikode",9865412357),
(2,101,"Kasarkode",8547126934),
(3,102,"Malappuram",9832654710),
(4,103,"Wayanad",8975201364),
(5,104,"Ernakulam",9120369877);

SELECT * FROM Branch;

INSERT INTO Employee VALUES
(100,'Tharun','Account',30000.00),
(101,'Jalakshmi','Casier',35000.00),
(102,'Lakshmi','Manager',50000.00),
(103,'Niranjan','Sales Manager',45000.00),
(104,'Preetha','Clerk',20000.00);

SELECT * FROM  Employee ;

INSERT INTO Coustomer VALUES
(1,'Venu','Naduvannur','2023-06-12'),
(2,'Sethu','Kanjangad ','2023-05-22'),
(3,'Seema','Kochi','2021-02-11'),
(4,'Krishna','Chingapuram','2020-03-18'),
(5,'Danya','Koyilandy','2022-02-04'),
(6,'Shinu','Kochi','2021-10-01'),
(7,'Janu','Kollam','2020-11-21'),
(8,'Meera','TVM','2020-03-21'),
(9,'Shyma','Pathanamthitta','2022-04-15'),
(10,'Nethra','Calicut','2020-07-13');

SELECT * FROM Coustomer;

INSERT INTO Books VALUES
("9781164589","Jane Eyre","Article","30.00","Yes","Charlotte Bronte","Smith, Elder and Co.");
INSERT INTO Books VALUES
("9461263289","A Tail Of Two Cities","historical novel","20.00","No","Charles Dickens","Penguin Classics");
INSERT INTO Books VALUES
("8462113459","Littile Women","Drama","10.00","No","Louisa May Alcott","Roberts Brothers");
INSERT INTO Books VALUES
("9432251259","Great Expectations"," literature","15.00","Yes","Charles Dickens","Simon & Schuster");
INSERT INTO Books VALUES
("9481203045","Crime And Punishment"," noveL","20.00","No","Fyodor Dostoevsky","Simon & Schuster");
INSERT INTO Books VALUES
("9312202146","War And Peace"," fiction","35.00","No","Leo Tolstoy","The Russian Messenger");
INSERT INTO Books VALUES
("9183123646","The Secrete Garden"," Novel","40.00","No","Frances Hodgson Burnett","Frederick A. Stokes (US)");
INSERT INTO Books VALUES
("9121412362","The Call Of The Wild"," novel","10.00","Yes"," Jack London","‎Maple Press");
INSERT INTO Books VALUES
("7122312152","Sense And Sensibility"," novel","20.00","No","Jane Austen","	Thomas Egerton, Military Library");
INSERT INTO Books VALUES
("9722114520","Black Beauty"," novel","10.00","No","Anna Sewell","‎Maple Press ");
INSERT INTO Books VALUES
("9721314540","Wolf Hall","History","15.00","Yes","Hilary MANTEL","Fourth Estate ");

SELECT * FROM Books;


INSERT INTO issue_status VALUES
(500,1,"Jane Eyre","2020-01-15","9781164589"),
(501,2,"The Secrete Garden","2021-06-20","9183123646"),
(502,3,"Sense And Sensibility","2020-01-18","7122312152"),
(503,4,"War And Peace","2019-11-30","9312202146"),
(504,5,"Crime And Punishment","2022-01-24","9481203045");

SELECT * FROM  issue_status ;


INSERT INTO Returnstatus VALUES
(500,1,"Jane Eyre","2020-03-25","9781164589"),
(501,2,"The Secrete Garden","2021-08-13","9183123646"),
(502,3,"Sense And Sensibility","2020-04-25","7122312152"),
(503,4,"War And Peace","2020-01-05","9312202146"),
(504,5,"Crime And Punishment","2022-05-04","9481203045");

SELECT * FROM  Returnstatus ;

-- 1.  Retrieve the book title, category, and rental price of all available books.

SELECT Book_title ,Categary,Rental_price AND Rental_price FROM Books WHERE Status ='Yes';

-- 2. List the employee names and their respective salaries in descending order of salary. 

SELECT Emp_name , Salary FROM Employee ORDER BY SALARY DESC ;

-- 3 . Retrieve the book titles and the corresponding customers who have issued those books.

SELECT issue_status.Issued_book_name,Coustomer.Coustomer_name FROM issue_status
 INNER JOIN Coustomer ON issue_status.Issued_cust=Coustomer.Coustomer_id ;

-- 4.  Display the total count of books in each category. 

SELECT Categary, COUNT(*) AS Total_count FROM Books GROUP BY  Categary;

-- 5.  Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.

SELECT Emp_name,Position FROM Employee WHERE Salary>50000;

-- 6.  List the customer names who registered before 2022-01-01 and have not issued any books yet.

SELECT Coustomer_name FROM Coustomer WHERE Reg_date< "2022-01-01" AND 
Coustomer_id  NOT IN (SELECT Issued_cust FROM issue_status);

-- 7.   Display the branch numbers and the total count of employees in each branch.

SELECT Branch.Branch_no , COUNT( Employee.Emp_id) AS Total_employee FROM Branch LEFT JOIN Employee 
ON Branch.Manager_id=employee.Emp_id GROUP BY Branch.Branch_no ;


-- 8.  Display the names of customers who have issued books in the month of June 2023. 
 
SELECT  Coustomer.Coustomer_name 
FROM Coustomer JOIN issue_status ON Coustomer.Coustomer_id= issue_status.Issued_cust
WHERE MONTH(issue_status.Issue_date )=6 AND YEAR(issue_status.Issue_date)=2023;

-- 9.  Retrieve book_title from book table containing history. 

SELECT Book_title FROM Books WHERE Categary="History";


-- 10  Retrieve the branch numbers along with the count of employees for branches having more than 5 employees. 


SELECT Branch.branch_no, COUNT(*) AS Total_employees
FROM Branch LEFT JOIN employee ON Branch.Manager_id= Employee.Emp_id
GROUP BY Branch.Branch_no having Total_employees >5;
