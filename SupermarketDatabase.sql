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

INSERT INTO Maker VALUES ('Верея', 'Пловдив 4003 бул. "Дунав" No 3', 'България');
INSERT INTO Maker VALUES ('Olympus', 'ул. „Околовръстен път“ 414, 1532 София', 'България');
INSERT INTO Maker VALUES ('Milka', 'адресМилка', 'Германия');
INSERT INTO Maker VALUES ('Nestle', 'адресНестле', 'Швейцария');
INSERT INTO Maker VALUES ('Coca-Cola', 'адресКака-Кола', 'САЩ');
	
INSERT INTO Products VALUES ('Кисело мляко 2% Верея 400гр', 'Верея', 'млечни', 0.90, 1.09, '2020-06-20');
INSERT INTO Products VALUES ('Кисело мляко 3,6% Верея 400гр', 'Верея', 'млечни', 0.90, 1.09, '2020-06-20');
INSERT INTO Products VALUES ('Прясно мляко 2% Верея 1л', 'Верея', 'млечни', 1.80, 2.09, '2020-06-12');
INSERT INTO Products VALUES ('Кисело мляко 3,6% Olympus 400гр', 'Olympus', 'млечни', 0.99, 1.29, '2020-06-12');
INSERT INTO Products VALUES ('Млечен шоколад Милка 300гр', 'Milka', 'сладки изделия', 1.49, 1.79, '2020-12-18');
INSERT INTO Products VALUES ('Млечен бял шоколад Милка 300гр', 'Milka', 'сладки изделия', 1.49, 1.79, '2020-12-18');
INSERT INTO Products VALUES ('Млечен шоколад аеро Nestle 200гр', 'Nestle', 'сладки изделия', 1.00, 1.29, '2020-12-18');
INSERT INTO Products VALUES ('Nescafe 3in1 Nestle 60гр', 'Nestle', 'кафе', 0.29, 0.39, '2021-03-10');
INSERT INTO Products VALUES ('Nescafe 3in1 ice Nestle 60гр', 'Nestle', 'кафе', 0.29, 0.39, '2021-03-10');
INSERT INTO Products VALUES ('Coca-Cola 1.5л', 'Coca-Cola', 'напитки', 1.69, 1.99, '2020-11-28');
INSERT INTO Products VALUES ('Fanta лимон 2л', 'Coca-Cola', 'напитки', 1.79, 2.29, '2020-10-25');
INSERT INTO Products VALUES ('Sprite 2л', 'Coca-Cola', 'напитки', 1.79, 2.29, '2020-11-28');

INSERT INTO Inventory VALUES ('Кисело мляко 2% Верея 400гр', 'бр', 150);
INSERT INTO Inventory VALUES ('Кисело мляко 3,6% Верея 400гр', 'бр', 100);
INSERT INTO Inventory VALUES ('Прясно мляко 2% Верея 1л', 'бр', 100);
INSERT INTO Inventory VALUES ('Кисело мляко 3,6% Olympus 400гр', 'бр', 27);
INSERT INTO Inventory VALUES ('Млечен шоколад Милка 300гр', 'бр', 200);
INSERT INTO Inventory VALUES ('Млечен бял шоколад Милка 300гр', 'бр', 46);
INSERT INTO Inventory VALUES ('Млечен шоколад аеро Nestle 200гр', 'бр', 100);
INSERT INTO Inventory VALUES ('Nescafe 3in1 Nestle 60гр', 'бр', 224);
INSERT INTO Inventory VALUES ('Nescafe 3in1 ice Nestle 60гр', 'бр', 167);
INSERT INTO Inventory VALUES ('Coca-Cola 1.5л', 'бр', 289);
INSERT INTO Inventory VALUES ('Fanta лимон 2л', 'бр', 78);
INSERT INTO Inventory VALUES ('Sprite 2л', 'бр', 78);

INSERT INTO STAFF VALUES (1, 'Иван Г.','ул.Васил Левски 23', '21214', 'София', 40, 'управител');
INSERT INTO STAFF VALUES (2, 'Петя','ул.Христо Ботев 14', '21831', 'София', 35, 'зам. управител');
INSERT INTO STAFF VALUES (3, 'Димитър','ул.Цар Асен 16', '21933', 'Перник', 32, 'мениджър продажби');
INSERT INTO STAFF VALUES (4, 'Елена','ул.Васил Априлов 3', '28345', 'Вакарел', 30, 'аранжор');
INSERT INTO STAFF  VALUES (5, 'Кирил','ул.Акад.Борис Стефанов 8', '28112', 'Ихтиман', 25, 'аранжор');
INSERT INTO STAFF  VALUES (6, 'Георги','ул.Теменужка 23', '28463', 'София', 27, 'аранжор');
 INSERT INTO STAFF  VALUES (7, 'Соня','ул. Княз Борис 33', '23752', 'София', 25, 'оператор въвеждане на данни');
 INSERT INTO STAFF VALUES (8, 'Мария','ул. Кирил и Методи 15', '23456', 'Перник', 24, 'касиер');
INSERT INTO STAFF VALUES (9, 'Иван Д.','ул.Христо Смирненски 6', '22816', 'София', 31, 'касиер');
INSERT INTO STAFF  VALUES (10, 'Кристина','Стефан Стамболов 12', '21456', 'София', 20, 'касиер');
INSERT INTO STAFF VALUES (11, 'Петър','ул.Патриарх Евтимий 4', '21923', 'София', 28, 
'касиер');

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



 INSERT INTO  Purchases VALUES(1,'2020-03-05 13:42:51',12.92, 'Иван Д.'); 
INSERT INTO  Purchases VALUES (2,'2020-04-18 11:36:23',1.95, 'Мария');  
INSERT INTO  Purchases VALUES (3,'2020-01-17 14:51:33',14.73, 'Кристина');
INSERT INTO  Purchases VALUES (4,'2020-04-15 18:22:13',10.45, 'Петър'); 
INSERT INTO  Purchases VALUES (5,'2020-02-08 10:48:54',3.07, 'Иван Д.'); 
INSERT INTO  Purchases VALUES (6,'2020-01-17 14:51:33',13.14, 'Мария');  
INSERT INTO  Purchases VALUES (7,'2020-05-09 15:22:15',3.87, 'Кристина');
INSERT INTO  Purchases VALUES (8,'2020-04-26 19:18:43',2.58, 'Петър'); 
INSERT INTO  Purchases VALUES (9,'2020-03-18 15:42:37',11.14, 'Иван Д.'); 
INSERT INTO  Purchases VALUES (10,'2020-04-23 16:12:08',14.31, 'Мария');  
INSERT INTO  Purchases VALUES (11,'2020-04-23 16:12:45',3.98, 'Мария');  


INSERT INTO  PurchasedItems VALUES(1,'Кисело мляко 2% Верея 400гр',4, 1.09);  
INSERT INTO  PurchasedItems VALUES(1, 'Fanta лимон 2л',2, 2.29);
INSERT INTO  PurchasedItems VALUES (1,'Coca-Cola 1.5л',2, 1.99);
INSERT INTO  PurchasedItems VALUES (2,'Nescafe 3in1 Nestle 60гр',5, 0.39); 
INSERT INTO  PurchasedItems VALUES (3,'Млечен бял шоколад Милка 300гр',2, 1.79);
INSERT INTO  PurchasedItems VALUES (3,'Sprite 2л',4, 2.29);
INSERT INTO  PurchasedItems VALUES (3,'Coca-Cola 1.5л',1, 1.99);  
INSERT INTO  PurchasedItems VALUES (4,'Прясно мляко 2% Верея 1л',5, 2.09);   
INSERT INTO  PurchasedItems VALUES (5,'Nescafe 3in1 ice Nestle 60гр',2, 0.39);  
INSERT INTO  PurchasedItems VALUES (5,'Fanta лимон 2л',1, 2.29);
INSERT INTO  PurchasedItems VALUES (6,'Sprite 2л',2, 2.29);
INSERT INTO  PurchasedItems VALUES (6,'Coca-Cola 1.5л',2, 1.99);
INSERT INTO  PurchasedItems VALUES (6,'Fanta лимон 2л',2, 2.29);
INSERT INTO  PurchasedItems VALUES (7,'Кисело мляко 3,6% Olympus 400гр',3, 1.29);
INSERT INTO  PurchasedItems VALUES (8,'Млечен шокола аеро Nestle 200гр',2, 1.29);
INSERT INTO  PurchasedItems VALUES (9,'Млечен шоколад Милка 300гр',4, 1.79);
INSERT INTO  PurchasedItems VALUES (9,'Coca-Cola 1.5л',2, 1.99);
INSERT INTO  PurchasedItems VALUES(10, 'Fanta лимон 2л',4, 2.29); 
INSERT INTO  PurchasedItems VALUES (10,'Nescafe 3in1 Nestle 60гр',3, 0.39);
INSERT INTO  PurchasedItems VALUES (10,'Coca-Cola 1.5л',2, 1.99);
INSERT INTO  PurchasedItems VALUES (11,'Coca-Cola 1.5л',2, 1.99);


INSERT INTO Deliveries VALUES (1, '2020-05-01', 'EuroTrans', 702.10);
INSERT INTO Deliveries VALUES (2, '2020-04-28', 'EuroTrans', 528.00);
INSERT INTO Deliveries VALUES (3, '2020-04-28', 'Acont89', 1234.10);
INSERT INTO Deliveries VALUES (4, '2020-04-30', 'БгТрансКом', 347.70);
INSERT INTO Deliveries VALUES (5, '2020-05-02', 'Арбитър ЕООД', 375.30);
INSERT INTO Deliveries VALUES (6, '2020-04-15', 'Арбитър ЕООД', 601.50);
INSERT INTO Deliveries VALUES (7, '2020-05-10', 'БгТрансКом', 501.20);
INSERT INTO Deliveries VALUES (8, '2020-03-21', 'EuroTrans', 813.35);
INSERT INTO Deliveries VALUES (9, '2020-03-14', 'СимплексКом', 469.80);
INSERT INTO Deliveries VALUES (10, '2020-03-06', 'Acont89', 756.90);


INSERT INTO DeliveriesDetails VALUES (1, 'Млечен шоколад Милка 300гр', 1.49, 100);
INSERT INTO DeliveriesDetails VALUES (1, 'Coca-Cola 1.5л', 1.69, 100);
INSERT INTO DeliveriesDetails VALUES (1, 'Sprite 2л', 1.79, 200);
INSERT INTO DeliveriesDetails VALUES (1, 'Nescafe 3in1 Nestle 60гр', 0.29, 90);
INSERT INTO DeliveriesDetails VALUES (2, 'Sprite 2л', 1.79, 200);
INSERT INTO DeliveriesDetails VALUES (2, 'Кисело мляко 2% Верея 400гр', 0.89, 90);
INSERT INTO DeliveriesDetails VALUES (2, 'Nescafe 3in1 Nestle 60гр', 0.29, 310);
INSERT INTO DeliveriesDetails VALUES (3, 'Млечен шокола аеро Nestle 200гр', 1.00, 120);
INSERT INTO DeliveriesDetails VALUES (3, 'Кисело мляко 3,6% Верея 400гр', 0.89, 90);
INSERT INTO DeliveriesDetails VALUES (3, 'Fanta лимон 2л', 1.79, 200);
INSERT INTO DeliveriesDetails VALUES (3, 'Coca-Cola 1.5л', 1.69, 400);
INSERT INTO DeliveriesDetails VALUES (4, 'Nescafe 3in1 ice Nestle 60гр', 0.29, 150);
INSERT INTO DeliveriesDetails VALUES (4, 'Coca-Cola 1.5л', 1.69, 180);
INSERT INTO DeliveriesDetails VALUES (5, 'Кисело мляко 3,6% Верея 400гр', 0.89, 120);
INSERT INTO DeliveriesDetails VALUES (5, 'Прясно мляко 2% Верея 1л', 1.79, 150);
INSERT INTO DeliveriesDetails VALUES (6, 'Млечен бял шоколад Милка 300гр', 1.49, 150);
INSERT INTO DeliveriesDetails VALUES (6, 'Млечен шоколад Милка 300гр', 1.49, 200);
INSERT INTO DeliveriesDetails VALUES (6, 'Млечен шокола аеро Nestle 200гр', 1.00, 80);
INSERT INTO DeliveriesDetails VALUES (7, 'Прясно мляко 2% Верея 1л', 1.79, 100);
INSERT INTO DeliveriesDetails VALUES (7, 'Fanta лимон 2л', 1.79, 180);
INSERT INTO DeliveriesDetails VALUES (8, 'Coca-Cola 1.5л', 1.69, 190);
INSERT INTO DeliveriesDetails VALUES (8, 'Fanta лимон 2л', 1.79, 100);
INSERT INTO DeliveriesDetails VALUES (8, 'Sprite 2л', 1.79, 175);
INSERT INTO DeliveriesDetails VALUES (9, 'Кисело мляко 3,6% Верея 400гр', 0.89, 160);
INSERT INTO DeliveriesDetails VALUES (9, 'Кисело мляко 2% Верея 400гр', 0.89, 140);
INSERT INTO DeliveriesDetails VALUES (9, 'Coca-Cola 1.5л', 1.69, 120);
INSERT INTO DeliveriesDetails VALUES (10, 'Nescafe 3in1 ice Nestle 60гр', 0.29, 90);
INSERT INTO DeliveriesDetails VALUES (10, 'Млечен шоколад Милка 300гр', 1.49, 70);
INSERT INTO DeliveriesDetails VALUES (10, 'Fanta лимон 2л', 1.79, 350);

 
 
 
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




