/*
 
LAUNDRY MANAGEMENT SYSTEM
PHASE 3 - SQ SCRIPT

*/


/*
------------------------
1. DDL  CREATION
------------------------
*/
CREATE DATABASE IF NOT EXISTS laundry_management; 
USE laundry_management; 
 
CREATE TABLE Customer ( 
    Customer_ID INT AUTO_INCREMENT, 
    Customer_Name VARCHAR(100) NOT NULL, 
    Customer_Contact VARCHAR(20) NOT NULL, 
    Customer_Email VARCHAR(100), 
    Customer_Address VARCHAR(255) NOT NULL, 
    PRIMARY KEY (Customer_ID), 
    UNIQUE (Customer_Email) 
) ENGINE=InnoDB; 
 
CREATE TABLE Staff ( 
    Staff_ID INT AUTO_INCREMENT, 
    Staff_Name VARCHAR(100) NOT NULL, 
    Staff_Contact VARCHAR(20) NOT NULL, 
    Staff_Position VARCHAR(50) NOT NULL, 
    Staff_Username VARCHAR(50) NOT NULL, 
    PRIMARY KEY (Staff_ID), 
    UNIQUE (Staff_Username) 
) ENGINE=InnoDB; 
 
CREATE TABLE Order_Status ( 
    Status_ID INT AUTO_INCREMENT, 
    Status_Name VARCHAR(50) NOT NULL, 
    Status_Description VARCHAR(255), 
    PRIMARY KEY (Status_ID), 
    UNIQUE (Status_Name) 
) ENGINE=InnoDB; 
 
CREATE TABLE Laundry_Order ( 
    Order_ID INT AUTO_INCREMENT, 
    Pickup_Code VARCHAR(30) NOT NULL, 
    Order_Date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    Expected_Claim_Date DATE NOT NULL, 
    Current_Status_ID INT NOT NULL, 
    Customer_ID INT NOT NULL, 
    Staff_ID INT NOT NULL, 
    PRIMARY KEY (Order_ID), 
    UNIQUE (Pickup_Code), 
    FOREIGN KEY (Current_Status_ID) 
        REFERENCES Order_Status(Status_ID) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE, 
    FOREIGN KEY (Customer_ID) 
        REFERENCES Customer(Customer_ID) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE, 
    FOREIGN KEY (Staff_ID) 
        REFERENCES Staff(Staff_ID) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE, 
    CHECK (Expected_Claim_Date >= DATE(Order_Date)) 
) ENGINE=InnoDB; 
 
CREATE TABLE Laundry_Item ( 
    Item_ID INT AUTO_INCREMENT, 
    Order_ID INT NOT NULL, 
    Item_Description VARCHAR(255) NOT NULL, 
    Item_Quantity INT NOT NULL, 
    Item_Weight DECIMAL(6,2) NOT NULL, 
    PRIMARY KEY (Item_ID), 
    FOREIGN KEY (Order_ID) 
        REFERENCES Laundry_Order(Order_ID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE, 
    CHECK (Item_Quantity > 0), 
    CHECK (Item_Weight > 0) 
) ENGINE=InnoDB; 
 
CREATE TABLE Laundry_Service ( 
    Service_ID INT AUTO_INCREMENT, 
    Service_Name VARCHAR(100) NOT NULL, 
    Service_Description VARCHAR(255), 
    Service_Price_Per_Kg DECIMAL(10,2) NOT NULL, 
    PRIMARY KEY (Service_ID), 
    UNIQUE (Service_Name), 
    CHECK (Service_Price_Per_Kg > 0) 
) ENGINE=InnoDB; 
 
CREATE TABLE Order_Service ( 
    Order_ID INT NOT NULL, 
    Service_ID INT NOT NULL, 
    Quantity INT NOT NULL, 
    Service_Price DECIMAL(10,2) NOT NULL, 
    PRIMARY KEY (Order_ID, Service_ID), 
    FOREIGN KEY (Order_ID) 
        REFERENCES Laundry_Order(Order_ID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE, 
    FOREIGN KEY (Service_ID) 
        REFERENCES Laundry_Service(Service_ID) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE, 
    CHECK (Quantity > 0), 
    CHECK (Service_Price > 0) 
) ENGINE=InnoDB; 
 
CREATE TABLE Status_History ( 
    Status_History_ID INT AUTO_INCREMENT, 
    Order_ID INT NOT NULL, 
    Status_ID INT NOT NULL, 
    Staff_ID INT NOT NULL, 
    Status_DateTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    Status_Remarks VARCHAR(255), 
    PRIMARY KEY (Status_History_ID), 
    FOREIGN KEY (Order_ID) 
        REFERENCES Laundry_Order(Order_ID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE, 
    FOREIGN KEY (Status_ID) 
        REFERENCES Order_Status(Status_ID) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE, 
    FOREIGN KEY (Staff_ID) 
        REFERENCES Staff(Staff_ID) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE 
) ENGINE=InnoDB; 
 
CREATE TABLE Payment ( 
    Payment_ID INT AUTO_INCREMENT, 
    Order_ID INT NOT NULL, 
    Payment_Date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    Payment_Amount DECIMAL(10,2) NOT NULL, 
    Payment_Method VARCHAR(30) NOT NULL, 
    Payment_Status VARCHAR(30) NOT NULL, 
    PRIMARY KEY (Payment_ID), 
    FOREIGN KEY (Order_ID) 
        REFERENCES Laundry_Order(Order_ID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE, 
    CHECK (Payment_Amount > 0), 
    CHECK (Payment_Status IN ('Pending', 'Paid', 'Failed', 'Refunded')) 
) ENGINE=InnoDB; 
 
CREATE TABLE Notification ( 
    Notification_ID INT AUTO_INCREMENT, 
    Customer_ID INT NOT NULL, 
    Order_ID INT NOT NULL, 
    Notification_Message VARCHAR(500) NOT NULL, 
    Notification_DateTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    Notification_Status VARCHAR(30) NOT NULL, 
    PRIMARY KEY (Notification_ID), 
    FOREIGN KEY (Customer_ID) 
        REFERENCES Customer(Customer_ID) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE, 
    FOREIGN KEY (Order_ID) 
        REFERENCES Laundry_Order(Order_ID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE, 
    CHECK (Notification_Status IN ('Unread', 'Read')) 
) ENGINE=InnoDB; 
 
CREATE TABLE Claim ( 
    Claim_ID INT AUTO_INCREMENT, 
    Order_ID INT NOT NULL, 
    Customer_ID INT NOT NULL, 
    Claim_DateTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    Verified_By_Staff_ID INT NOT NULL, 
    PRIMARY KEY (Claim_ID), 
    FOREIGN KEY (Order_ID) 
        REFERENCES Laundry_Order(Order_ID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE, 
    FOREIGN KEY (Customer_ID) 
        REFERENCES Customer(Customer_ID) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE, 
    FOREIGN KEY (Verified_By_Staff_ID) 
        REFERENCES Staff(Staff_ID) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE 
) ENGINE=InnoDB; laundry_managementlaundry_management

/*
--------------------------
2. SAMPLE DATA INSERTION
--------------------------
*/

USE laundry_management;
INSERT INTO Customer 
(Customer_Name, Customer_Contact, Customer_Email, Customer_Address) 
VALUES 
('Maria Santos', '09171234567', 'maria@gmail.com', 'Lagonoy, Camarines Sur'), 
('Juan Dela Cruz', '09181234567', 'juan@gmail.com', 'Nabua, Camarines Sur'), 
('Ana Reyes', '09191234567', 'ana@gmail.com', 'Iriga City'), 
('Mark Garcia', '09201234567', 'mark@gmail.com', 'Naga City'), 
('Sofia Cruz', '09211234567', 'sofia@gmail.com', 'Lagonoy, Camarines Sur'), 
('Carlo Mendoza', '09221234567', 'carlo@gmail.com', 'Goa, Camarines Sur'), 
('Liza Ramos', '09231234567', 'liza@gmail.com', 'Tigaon, Camarines Sur'), 
('Paolo Fernandez', '09241234567', 'paolo@gmail.com', 'Nabua, Camarines Sur'), 
('Ella Navarro', '09251234567', 'ella@gmail.com', 'Iriga City'), 
('Kevin Flores', '09261234567', 'kevin@gmail.com', 'Naga City'); -- 2. STAFF 
INSERT INTO Staff 
(Staff_Name, Staff_Contact, Staff_Position, Staff_Username) 
VALUES 
('John Smith', '09301234567', 'Manager', 'johnsmith'), 
('Angela Torres', '09311234567', 'Cashier', 'angelatorres'), 
('Mark Lopez', '09321234567', 'Laundry Staff', 'marklopez'), 
('Grace Aquino', '09331234567', 'Laundry Staff', 'graceaquino'), 
('Daniel Perez', '09341234567', 'Cashier', 'danielperez'); -- 3. ORDER STATUS 
INSERT INTO Order_Status 
(Status_Name, Status_Description) 
VALUES 
('Received', 'Laundry order has been received'), 
('Washing', 'Laundry is currently being washed'), 
('Drying', 'Laundry is currently being dried'), 
('Ready', 'Laundry is ready for claiming'), 
('Claimed', 'Laundry has been claimed by the customer'); -- 4. LAUNDRY SERVICES 
INSERT INTO Laundry_Service 
(Service_Name, Service_Description, Service_Price_Per_Kg) 
VALUES 
('Wash and Fold', 'Standard washing and folding service', 60.00), 
('Wash and Dry', 'Washing and machine drying service', 80.00), 
('Dry Cleaning', 'Dry cleaning service for delicate clothes', 150.00), 
('Ironing', 'Clothes ironing service', 40.00), 
('Express Laundry', 'Fast laundry service', 100.00); -- 5. LAUNDRY ORDERS 
INSERT INTO Laundry_Order 
(Pickup_Code, Order_Date, Expected_Claim_Date, Current_Status_ID, Customer_ID, Staff_ID) 
VALUES 
('PK001', '2026-09-20 09:00:00', '2026-09-21', 1, 1, 1), 
('PK002', '2026-09-20 10:00:00', '2026-09-21', 2, 2, 2), 
('PK003', '2026-09-21 08:30:00', '2026-09-22', 3, 3, 3), 
('PK004', '2026-09-21 09:15:00', '2026-09-22', 4, 4, 1), 
('PK005', '2026-09-22 11:00:00', '2026-09-23', 5, 5, 2), 
('PK006', '2026-09-22 13:00:00', '2026-09-23', 1, 6, 3), 
('PK007', '2026-09-23 08:45:00', '2026-09-24', 2, 7, 4), 
('PK008', '2026-09-23 10:30:00', '2026-09-24', 3, 8, 5), 
('PK009', '2026-09-24 09:20:00', '2026-09-25', 4, 9, 1), 
('PK010', '2026-09-24 14:00:00', '2026-09-25', 5, 10, 2); -- 6. LAUNDRY ITEMS 
INSERT INTO Laundry_Item 
(Order_ID, Item_Description, Item_Quantity, Item_Weight) 
VALUES 
(1, 'T-Shirts', 5, 2.50), 
(1, 'Pants', 2, 1.80), 
(2, 'School Uniforms', 3, 2.20), 
(3, 'Bedsheets', 2, 3.50), 
(4, 'Towels', 5, 2.80), 
(5, 'Jeans', 3, 2.40), 
(6, 'T-Shirts', 6, 2.70), 
(7, 'Polo Shirts', 4, 2.10), 
(8, 'Curtains', 2, 4.00), 
(9, 'School Uniforms', 4, 2.60), 
(10, 'Jackets', 2, 2.30); -- 7. ORDER SERVICES 
INSERT INTO Order_Service 
(Order_ID, Service_ID, Quantity, Service_Price) 
VALUES 
(1, 1, 3, 60.00), 
(2, 2, 3, 80.00), 
(3, 3, 4, 150.00), 
(4, 1, 3, 60.00), 
(5, 4, 2, 40.00), 
(6, 2, 3, 80.00), 
(7, 1, 4, 60.00), 
(8, 5, 2, 100.00), 
(9, 2, 3, 80.00), 
(10, 1, 3, 60.00); -- 8. STATUS HISTORY 
INSERT INTO Status_History 
(Order_ID, Status_ID, Staff_ID, Status_DateTime, Status_Remarks) 
VALUES 
(1, 1, 1, '2026-09-20 09:05:00', 'Order received'), 
(2, 2, 2, '2026-09-20 11:00:00', 'Washing started'), 
(3, 3, 3, '2026-09-21 13:00:00', 'Drying started'), 
(4, 4, 1, '2026-09-22 15:00:00', 'Ready for pickup'), 
(5, 5, 2, '2026-09-23 10:00:00', 'Order claimed'), 
(6, 1, 3, '2026-09-22 13:10:00', 'Order received'), 
(7, 2, 4, '2026-09-23 10:00:00', 'Washing started'), 
(8, 3, 5, '2026-09-23 15:00:00', 'Drying started'), 
(9, 4, 1, '2026-09-25 09:00:00', 'Ready for pickup'), 
(10, 5, 2, '2026-09-26 10:00:00', 'Order claimed'); -- 9. PAYMENTS 
INSERT INTO Payment 
(Order_ID, Payment_Date, Payment_Amount, Payment_Method, Payment_Status) 
VALUES 
(1, '2026-09-20 09:10:00', 180.00, 'Cash', 'Paid'), 
(2, '2026-09-20 10:10:00', 240.00, 'GCash', 'Paid'), 
(3, '2026-09-21 08:40:00', 600.00, 'Cash', 'Paid'), 
(4, '2026-09-21 09:20:00', 180.00, 'GCash', 'Paid'), 
(5, '2026-09-22 11:10:00', 80.00, 'Cash', 'Paid'), 
(6, '2026-09-22 13:10:00', 240.00, 'GCash', 'Paid'), 
(7, '2026-09-23 08:50:00', 240.00, 'Cash', 'Paid'), 
(8, '2026-09-23 10:40:00', 200.00, 'GCash', 'Paid'), 
(9, '2026-09-24 09:30:00', 240.00, 'Cash', 'Paid'), 
(10, '2026-09-24 14:10:00', 180.00, 'GCash', 'Paid'); -- 10. NOTIFICATIONS 
INSERT INTO Notification 
(Customer_ID, Order_ID, Notification_Message, Notification_DateTime, Notification_Status) 
VALUES 
(1, 1, 'Your laundry order has been received.', '2026-09-20 09:15:00', 'Read'), 
(2, 2, 'Your laundry is currently being washed.', '2026-09-20 11:05:00', 'Read'), 
(3, 3, 'Your laundry is currently being dried.', '2026-09-21 13:05:00', 'Unread'), 
(4, 4, 'Your laundry is ready for claiming.', '2026-09-22 15:05:00', 'Read'), 
(5, 5, 'Your laundry has been claimed.', '2026-09-23 10:05:00', 'Read'), 
(6, 6, 'Your laundry order has been received.', '2026-09-22 13:15:00', 'Unread'), 
(7, 7, 'Your laundry is currently being washed.', '2026-09-23 10:05:00', 'Unread'), 
(8, 8, 'Your laundry is currently being dried.', '2026-09-23 15:05:00', 'Read'), 
(9, 9, 'Your laundry is ready for claiming.', '2026-09-25 09:05:00', 'Unread'), 
(10, 10, 'Your laundry has been claimed.', '2026-09-26 10:05:00', 'Read'); -- 11. CLAIMS 
INSERT INTO Claim 
(Order_ID, Customer_ID, Claim_DateTime, Verified_By_Staff_ID) 
VALUES 
(5, 5, '2026-09-23 10:00:00', 2), 
(10, 10, '2026-09-26 10:00:00', 2); 

/*
------------------------------------------
3. PERFORMANCE TESTING - BEFORE INDEXING
------------------------------------------
*/

USE laundry_management; 
SELECT 
    o.Order_ID, 
    o.Pickup_Code, 
    c.Customer_Name, 
    s.Status_Name, 
    o.Order_Date 
FROM Laundry_Order o 
JOIN Customer c 
    ON o.Customer_ID = c.Customer_ID 
JOIN Order_Status s 
    ON o.Current_Status_ID = s.Status_ID 
WHERE o.Customer_ID = 5;


/*
--------------------
4. INDEX CREATION
--------------------
*/

CREATE INDEX idx_laundry_order_customer
ON laundry_order(Customer_ID);

CREATE INDEX idx_laundry_order_status
ON laundry_order(Current_Status_ID);

CREATE INDEX idx_laundry_order_date
ON laundry_order(Order_Date);

/*
------------------------------------------
3. PERFORMANCE TESTING - AFTER INDEXING
------------------------------------------
*/

SELECT 
   o.Order_ID, 
   o.Pickup_Code, 
	c.Customer_Name, 
	s.Status_Name, 
	o.Order_Date 
FROM Laundry_Order o 
JOIN Customer c 
ON o.Customer_ID = c.Customer_ID 
JOIN Order_Status s 
ON o.Current_Status_ID = s.Status_ID 
WHERE o.Customer_ID = 5;
