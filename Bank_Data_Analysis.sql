/*Create database mybank;
use mybank;
show tables
select * from accounts_data;
select * from Customers;
select * from Transactions;
select * from Loans;
select * from Credit_cards;
select * from Branches;
select * from ATMs
select count(*) As TotalCustomers from Customers;
select count(*) As TotalAccounts from accounts_data;
select sum(Amount) As TotalLoansAmount from Loans;
select sum(CreditLimit) As TotalCreditLimit from Credit_cards;
select * from accounts_data where Status='Active';
select * from Transactions where Transactiondate > '2023-01-15';
select * from Loans where InterestRate>5.0;
select * from Credit_cards where balance > CreditLimit;
select c.customerID, c.Name, c.Age, a.AccountNumber, a.accountType, a.Balance
from Customers c
join accounts_data a On c.CustomerID= a.CustomerID;
select t.TransactionID, t.Transactiondate, t.Amount, t.Type, t.Description, a.AccountNumber, a.Accounttype, c.Name As CustomerName
from Transactions t
Join accounts_data a On t.AccountNumber = a.AccountNumber
Join Customers c On a.CustomerID = c.CustomerID;
select c.Name, L.Amount As LoanAmount from Customers c
Join Loans L On c.CustomerID = L.CustomerID
Order by L.Amount Desc
Limit 10;
SET SQL_SAFE_UPDATES =0;
DELETE FROM accounts_data
where Status = 'Inactive';
select * from accounts_data;
select c.CustomerID, c.Name, count(a.AccountNumber) As NumAccounts
from Customers c
Join accounts_data a On c.CustomerID = a.CustomerID
Group By c.CustomerID, c.Name
Having Count(a.AccountNumber)>1;
select Substring(Name,1,3) As FirstThreeCharacterOfName
from Customers;
/*select 
Substring_Index(Name,' ',1) As FirstName,
Substring_Index(Name,' ',-1) As LastName
from Customers;
select * from Customers
where MOD(CustomerID,2) <> 0;
use mybank;
select Distinct Amount
from loans L1
where 5 =(
select count(Distinct Amount)
from Loans L2
where L2.Amount>=L1.Amount
);
Select max(Amount) As SecondHighestLoan
from Loans
Where Amount <(
Select Max(Amount)
from Loans
);
select CustomerID from accounts_data
where Status = 'Inactive';
select * from Customers
limit 1;
Select Now() As CurrentDateTime;----show current date and  time of laptop
Create Table CustomersClone Like Customers;
Insert Into CustomersClone 
Select * from Customers;
Select 
CustomerID,
DateDiff(EndDate, CurDate()) As DaysRemaining
from loans
where EndDate > CurDate(); #--how many days required for the customers to pay offf loans--
Select AccountNumber, Max(TransactionDate) As LatestTransactionDate
from Transactions
Group by AccountNumber;
Select Avg(Age) As AverageAge
from Customers;
select AccountNumber, Balance-----account with  less than minimum amount for account opened before 1st jan 2022-----
from accounts_data
where Balance < 2500
And OpenDate <= '2022-01-01'
Select * from Loans --Loans that currently active--
where EndDate >= CurDate()
And Status = 'Active'
select AccountNumber, Sum(Accounts) As TotalAmount
from Transactions
where Month(TransactionDate) = 6
And Year(TransactionDate) = 2023
Group By AccountNumber;
Select CustomerID, Avg(Balance) As AverageCreditCardBalance
from Credit_cards
Group By CustomerID;
Select Location, Count(*) As NumberOfActiveATMs
from Atms
where Status = 'Out Of Service'
Group By Location;*/