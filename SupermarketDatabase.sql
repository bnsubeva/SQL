 USE master
GO
if exists (select * from sysdatabases where name='Supermarket')
	DROP DATABASE Supermarket
GO

CREATE DATABASE Supermarket
GO
USE Supermarket
GO
 create table Staff(
	id INT NOT NULL,
	name VARCHAR(50) NOT NULL,
	address VARCHAR(50) NOT NULL,
	phone VARCHAR(10) NOT NULL,
	town VARCHAR(50) NOT NULL,
	age INT NOT NULL,
	position VARCHAR(50) NOT NULL,
	CONSTRAINT pk_staff PRIMARY KEY (id)
);

CREATE TABLE Schedule(
	time time(0) NOT NULL,
	dayofweek varchar(50) NOT NULL,
	date datetime NOT NULL,
	status bit NOT NULL,
	employee INT,
	CONSTRAINT PK_Schedule_1 PRIMARY KEY CLUSTERED (date),
	CONSTRAINT dk_shedule_staff FOREIGN KEY (employee) REFERENCES Staff(id)
);

create table  Maker(
	name VARCHAR(50) NOT NULL,
	address VARCHAR(50) NOT NULL,
	country VARCHAR(50) NOT NULL,
	CONSTRAINT pk_maker PRIMARY KEY(name)
);


create table Products(
	name VARCHAR(50) NOT NULL,
	maker VARCHAR(50) NOT NULL,
	type VARCHAR(50) NOT NULL,
	trade_price DECIMAL(10,2) NOT NULL,
	sale_price DECIMAL(10,2) NOT NULL,
	expiry_date DATE NOT NULL,
	CONSTRAINT pk_products PRIMARY KEY(name),
	CONSTRAINT fk_pr_maker FOREIGN KEY (maker) REFERENCES Maker(name)
);

create table Inventory(
	name VARCHAR(50) NOT NULL,
	packing VARCHAR(2) NOT NULL,
	qtty INT NOT NULL,
	CONSTRAINT pk_inv PRIMARY KEY (name),
	CONSTRAINT fk_inv_name FOREIGN KEY (name) REFERENCES Products (name)
);

create table Purchases(
	id INT NOT NULL,
	date DATE NOT NULL,
	totalSum DECIMAL(10,2) NOT NULL,
	cashier VARCHAR(50) NOT NULL,
	CONSTRAINT pk_purchases PRIMARY KEY (id)
);

create table PurchasedItems(
	purchaseID INT NOT NULL,
	itemName VARCHAR(50) NOT NULL,
	qtty INT NOT NULL,
	price DECIMAL(10,2) NOT NULL,
	CONSTRAINT pk_p_items PRIMARY KEY (purchaseID, itemName),
	CONSTRAINT fk_puri_pur FOREIGN KEY (purchaseID) REFERENCES Purchases(id),
	CONSTRAINT fk_puri_name FOREIGN KEY (itemName) REFERENCES Products (name)
);


create table DeliveriesDetails(
	deliveryId INT NOT NULL,
	productName VARCHAR(50) NOT NULL,
	productPrice DECIMAL(10,2) NOT NULL,
	qtty INT NOT NULL,
	CONSTRAINT pk_d_details PRIMARY KEY (deliveryId, productName),
	CONSTRAINT fk_deld_name FOREIGN KEY (productName) REFERENCES Products (name)
);


create table Deliveries(
	id INT NOT NULL,
	date DATE NOT NULL,
	company VARCHAR(50) NOT NULL,
	totalPrice DECIMAL(10,2) NOT NULL,
	CONSTRAINT pk_deliveries PRIMARY KEY (id)
);


ALTER TABLE DeliveriesDetails
ADD CONSTRAINT fk_deld_id FOREIGN KEY (deliveryId) REFERENCES Deliveries (id);

INSERT INTO Maker VALUES ('�����', '������� 4003 ���. "�����" No 3', '��������');
INSERT INTO Maker VALUES ('Olympus', '��. ������������� ��� 414, 1532 �����', '��������');
INSERT INTO Maker VALUES ('Milka', '����������', '��������');
INSERT INTO Maker VALUES ('Nestle', '�����������', '���������');
INSERT INTO Maker VALUES ('Coca-Cola', '���������-����', '���');
	
INSERT INTO Products VALUES ('������ ����� 2% ����� 400��', '�����', '������', 0.90, 1.09, '2020-06-20');
INSERT INTO Products VALUES ('������ ����� 3,6% ����� 400��', '�����', '������', 0.90, 1.09, '2020-06-20');
INSERT INTO Products VALUES ('������ ����� 2% ����� 1�', '�����', '������', 1.80, 2.09, '2020-06-12');
INSERT INTO Products VALUES ('������ ����� 3,6% Olympus 400��', 'Olympus', '������', 0.99, 1.29, '2020-06-12');
INSERT INTO Products VALUES ('������ ������� ����� 300��', 'Milka', '������ �������', 1.49, 1.79, '2020-12-18');
INSERT INTO Products VALUES ('������ ��� ������� ����� 300��', 'Milka', '������ �������', 1.49, 1.79, '2020-12-18');
INSERT INTO Products VALUES ('������ ������� ���� Nestle 200��', 'Nestle', '������ �������', 1.00, 1.29, '2020-12-18');
INSERT INTO Products VALUES ('Nescafe 3in1 Nestle 60��', 'Nestle', '����', 0.29, 0.39, '2021-03-10');
INSERT INTO Products VALUES ('Nescafe 3in1 ice Nestle 60��', 'Nestle', '����', 0.29, 0.39, '2021-03-10');
INSERT INTO Products VALUES ('Coca-Cola 1.5�', 'Coca-Cola', '�������', 1.69, 1.99, '2020-11-28');
INSERT INTO Products VALUES ('Fanta ����� 2�', 'Coca-Cola', '�������', 1.79, 2.29, '2020-10-25');
INSERT INTO Products VALUES ('Sprite 2�', 'Coca-Cola', '�������', 1.79, 2.29, '2020-11-28');

INSERT INTO Inventory VALUES ('������ ����� 2% ����� 400��', '��', 150);
INSERT INTO Inventory VALUES ('������ ����� 3,6% ����� 400��', '��', 100);
INSERT INTO Inventory VALUES ('������ ����� 2% ����� 1�', '��', 100);
INSERT INTO Inventory VALUES ('������ ����� 3,6% Olympus 400��', '��', 27);
INSERT INTO Inventory VALUES ('������ ������� ����� 300��', '��', 200);
INSERT INTO Inventory VALUES ('������ ��� ������� ����� 300��', '��', 46);
INSERT INTO Inventory VALUES ('������ ������� ���� Nestle 200��', '��', 100);
INSERT INTO Inventory VALUES ('Nescafe 3in1 Nestle 60��', '��', 224);
INSERT INTO Inventory VALUES ('Nescafe 3in1 ice Nestle 60��', '��', 167);
INSERT INTO Inventory VALUES ('Coca-Cola 1.5�', '��', 289);
INSERT INTO Inventory VALUES ('Fanta ����� 2�', '��', 78);
INSERT INTO Inventory VALUES ('Sprite 2�', '��', 78);

INSERT INTO STAFF VALUES (1, '���� �.','��.����� ������ 23', '21214', '�����', 40, '���������');
INSERT INTO STAFF VALUES (2, '����','��.������ ����� 14', '21831', '�����', 35, '���. ���������');
INSERT INTO STAFF VALUES (3, '�������','��.��� ���� 16', '21933', '������', 32, '�������� ��������');
INSERT INTO STAFF VALUES (4, '�����','��.����� ������� 3', '28345', '�������', 30, '�������');
INSERT INTO STAFF  VALUES (5, '�����','��.����.����� �������� 8', '28112', '�������', 25, '�������');
INSERT INTO STAFF  VALUES (6, '������','��.��������� 23', '28463', '�����', 27, '�������');
 INSERT INTO STAFF  VALUES (7, '����','��. ���� ����� 33', '23752', '�����', 25, '�������� ��������� �� �����');
 INSERT INTO STAFF VALUES (8, '�����','��. ����� � ������ 15', '23456', '������', 24, '������');
INSERT INTO STAFF VALUES (9, '���� �.','��.������ ���������� 6', '22816', '�����', 31, '������');
INSERT INTO STAFF  VALUES (10, '��������','������ ��������� 12', '21456', '�����', 20, '������');
INSERT INTO STAFF VALUES (11, '�����','��.�������� ������� 4', '21923', '�����', 28, 
'������');

  INSERT INTO Schedule VALUES ('13:30', 'Monday', 2020-11-28,1,1);
  INSERT INTO Schedule VALUES ('20:00', 'Satuday', 2020-03-02,0,2);
  INSERT INTO Schedule VALUES ('18:00', 'Satuday', 2020-05-03,1,4);
  INSERT INTO Schedule VALUES ('21:00', 'Thusday', 2020-05-23,1,5);
  INSERT INTO Schedule VALUES ('23:00', 'Satuday', 2020-02-20,0,6);
  INSERT INTO Schedule VALUES ('20:00', 'Wednesday', 2020-05-20,1,9);
  INSERT INTO Schedule VALUES ('18:00', 'Satuday', 2020-05-03,1,4);
  INSERT INTO Schedule VALUES ('21:30', 'Thusday', 2020-01-18,1,2);
  INSERT INTO Schedule VALUES ('22:51', 'Sunday', 2020-02-02,0,0);
  INSERT INTO Schedule VALUES ('15:00', 'Monday', 2020-05-21,1,9);



 INSERT INTO  Purchases VALUES(1,'2020-03-05 13:42:51',12.92, '���� �.'); 
INSERT INTO  Purchases VALUES (2,'2020-04-18 11:36:23',1.95, '�����');  
INSERT INTO  Purchases VALUES (3,'2020-01-17 14:51:33',14.73, '��������');
INSERT INTO  Purchases VALUES (4,'2020-04-15 18:22:13',10.45, '�����'); 
INSERT INTO  Purchases VALUES (5,'2020-02-08 10:48:54',3.07, '���� �.'); 
INSERT INTO  Purchases VALUES (6,'2020-01-17 14:51:33',13.14, '�����');  
INSERT INTO  Purchases VALUES (7,'2020-05-09 15:22:15',3.87, '��������');
INSERT INTO  Purchases VALUES (8,'2020-04-26 19:18:43',2.58, '�����'); 
INSERT INTO  Purchases VALUES (9,'2020-03-18 15:42:37',11.14, '���� �.'); 
INSERT INTO  Purchases VALUES (10,'2020-04-23 16:12:08',14.31, '�����');  
INSERT INTO  Purchases VALUES (11,'2020-04-23 16:12:45',3.98, '�����');  


INSERT INTO  PurchasedItems VALUES(1,'������ ����� 2% ����� 400��',4, 1.09);  
INSERT INTO  PurchasedItems VALUES(1, 'Fanta ����� 2�',2, 2.29);
INSERT INTO  PurchasedItems VALUES (1,'Coca-Cola 1.5�',2, 1.99);
INSERT INTO  PurchasedItems VALUES (2,'Nescafe 3in1 Nestle 60��',5, 0.39); 
INSERT INTO  PurchasedItems VALUES (3,'������ ��� ������� ����� 300��',2, 1.79);
INSERT INTO  PurchasedItems VALUES (3,'Sprite 2�',4, 2.29);
INSERT INTO  PurchasedItems VALUES (3,'Coca-Cola 1.5�',1, 1.99);  
INSERT INTO  PurchasedItems VALUES (4,'������ ����� 2% ����� 1�',5, 2.09);   
INSERT INTO  PurchasedItems VALUES (5,'Nescafe 3in1 ice Nestle 60��',2, 0.39);  
INSERT INTO  PurchasedItems VALUES (5,'Fanta ����� 2�',1, 2.29);
INSERT INTO  PurchasedItems VALUES (6,'Sprite 2�',2, 2.29);
INSERT INTO  PurchasedItems VALUES (6,'Coca-Cola 1.5�',2, 1.99);
INSERT INTO  PurchasedItems VALUES (6,'Fanta ����� 2�',2, 2.29);
INSERT INTO  PurchasedItems VALUES (7,'������ ����� 3,6% Olympus 400��',3, 1.29);
INSERT INTO  PurchasedItems VALUES (8,'������ ������ ���� Nestle 200��',2, 1.29);
INSERT INTO  PurchasedItems VALUES (9,'������ ������� ����� 300��',4, 1.79);
INSERT INTO  PurchasedItems VALUES (9,'Coca-Cola 1.5�',2, 1.99);
INSERT INTO  PurchasedItems VALUES(10, 'Fanta ����� 2�',4, 2.29); 
INSERT INTO  PurchasedItems VALUES (10,'Nescafe 3in1 Nestle 60��',3, 0.39);
INSERT INTO  PurchasedItems VALUES (10,'Coca-Cola 1.5�',2, 1.99);
INSERT INTO  PurchasedItems VALUES (11,'Coca-Cola 1.5�',2, 1.99);


INSERT INTO Deliveries VALUES (1, '2020-05-01', 'EuroTrans', 702.10);
INSERT INTO Deliveries VALUES (2, '2020-04-28', 'EuroTrans', 528.00);
INSERT INTO Deliveries VALUES (3, '2020-04-28', 'Acont89', 1234.10);
INSERT INTO Deliveries VALUES (4, '2020-04-30', '����������', 347.70);
INSERT INTO Deliveries VALUES (5, '2020-05-02', '������� ����', 375.30);
INSERT INTO Deliveries VALUES (6, '2020-04-15', '������� ����', 601.50);
INSERT INTO Deliveries VALUES (7, '2020-05-10', '����������', 501.20);
INSERT INTO Deliveries VALUES (8, '2020-03-21', 'EuroTrans', 813.35);
INSERT INTO Deliveries VALUES (9, '2020-03-14', '�����������', 469.80);
INSERT INTO Deliveries VALUES (10, '2020-03-06', 'Acont89', 756.90);


INSERT INTO DeliveriesDetails VALUES (1, '������ ������� ����� 300��', 1.49, 100);
INSERT INTO DeliveriesDetails VALUES (1, 'Coca-Cola 1.5�', 1.69, 100);
INSERT INTO DeliveriesDetails VALUES (1, 'Sprite 2�', 1.79, 200);
INSERT INTO DeliveriesDetails VALUES (1, 'Nescafe 3in1 Nestle 60��', 0.29, 90);
INSERT INTO DeliveriesDetails VALUES (2, 'Sprite 2�', 1.79, 200);
INSERT INTO DeliveriesDetails VALUES (2, '������ ����� 2% ����� 400��', 0.89, 90);
INSERT INTO DeliveriesDetails VALUES (2, 'Nescafe 3in1 Nestle 60��', 0.29, 310);
INSERT INTO DeliveriesDetails VALUES (3, '������ ������ ���� Nestle 200��', 1.00, 120);
INSERT INTO DeliveriesDetails VALUES (3, '������ ����� 3,6% ����� 400��', 0.89, 90);
INSERT INTO DeliveriesDetails VALUES (3, 'Fanta ����� 2�', 1.79, 200);
INSERT INTO DeliveriesDetails VALUES (3, 'Coca-Cola 1.5�', 1.69, 400);
INSERT INTO DeliveriesDetails VALUES (4, 'Nescafe 3in1 ice Nestle 60��', 0.29, 150);
INSERT INTO DeliveriesDetails VALUES (4, 'Coca-Cola 1.5�', 1.69, 180);
INSERT INTO DeliveriesDetails VALUES (5, '������ ����� 3,6% ����� 400��', 0.89, 120);
INSERT INTO DeliveriesDetails VALUES (5, '������ ����� 2% ����� 1�', 1.79, 150);
INSERT INTO DeliveriesDetails VALUES (6, '������ ��� ������� ����� 300��', 1.49, 150);
INSERT INTO DeliveriesDetails VALUES (6, '������ ������� ����� 300��', 1.49, 200);
INSERT INTO DeliveriesDetails VALUES (6, '������ ������ ���� Nestle 200��', 1.00, 80);
INSERT INTO DeliveriesDetails VALUES (7, '������ ����� 2% ����� 1�', 1.79, 100);
INSERT INTO DeliveriesDetails VALUES (7, 'Fanta ����� 2�', 1.79, 180);
INSERT INTO DeliveriesDetails VALUES (8, 'Coca-Cola 1.5�', 1.69, 190);
INSERT INTO DeliveriesDetails VALUES (8, 'Fanta ����� 2�', 1.79, 100);
INSERT INTO DeliveriesDetails VALUES (8, 'Sprite 2�', 1.79, 175);
INSERT INTO DeliveriesDetails VALUES (9, '������ ����� 3,6% ����� 400��', 0.89, 160);
INSERT INTO DeliveriesDetails VALUES (9, '������ ����� 2% ����� 400��', 0.89, 140);
INSERT INTO DeliveriesDetails VALUES (9, 'Coca-Cola 1.5�', 1.69, 120);
INSERT INTO DeliveriesDetails VALUES (10, 'Nescafe 3in1 ice Nestle 60��', 0.29, 90);
INSERT INTO DeliveriesDetails VALUES (10, '������ ������� ����� 300��', 1.49, 70);
INSERT INTO DeliveriesDetails VALUES (10, 'Fanta ����� 2�', 1.79, 350);

 
 
 
  use Supermarket
 SELECT*
 FROM Deliveries
 SELECT*
 FROM  DeliveriesDetails
 SELECT*
 FROM INVENTORY
 SELECT*
 FROM PRODUCTS
 SELECT*
 FROM PURCHASEDITEMS
 SELECT*
 FROM PURCHASES
 SELECT*
 FROM SCHEDULE
 SELECT*
 FROM STAFF




