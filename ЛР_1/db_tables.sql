--create database SERVICE_PROVIDING;
use SERVICE_PROVIDING;

create table ECARD(
	ID		char(10)	not null	primary key,
	BALANCE money
);

create table COMPANY(
	ID			int			 not null	identity	primary key,
	NAME		nvarchar(50),
	CITY		nvarchar(50),
	ECARD_ID	char(10)	 foreign key references ECARD(ID),
	DESCRIPTION nvarchar(255)
);

create table CUSTOMER(
	ID			int			 not null	identity	primary key,
	NAME		nvarchar(50),
	CITY		nvarchar(50),
	BIRTHDAY	date,
	ECARD_ID	char(10)	 foreign key references ECARD(ID)
);


create table SERV(
	ID			int		not null	identity	primary key,
	COMPANY_ID	int		foreign key	references	COMPANY(ID),	
	COST		money,
	DESCRIPTION	nvarchar(255)
);

create table CONTRACT_STATUS(
	ID		int		not null	identity	primary key,
	NAME	char(20)
);

insert into CONTRACT_STATUS(NAME) 
	values
		('active'),
		('done'),
		('not done')

create table CONTRACT(
	ID			int		not null	identity	primary key,
	SERVICE_ID	int		foreign key	references	SERV(ID),
	COMPANY_ID	int		foreign key references	COMPANY(ID),
	CUSTOMER_ID	int		foreign key	references	CUSTOMER(ID),
	STATUS_ID	int		foreign key references	CONTRACT_STATUS(ID),
	DATE		date
);


--------------------------- Insert Data ---------------------------
insert into CONTRACT_STATUS(NAME)
	values
		('active'),
		('done'),
		('not done');

insert into ECARD(ID, BALANCE)
	values
		('100-00-00', 6777.98),
		('101-01-01', 2739.77),
		('102-02-02', 2246.04),
		('103-03-03', 1352.45),
		('104-04-04', 4982.36),
		('105-05-05', 8794.10),
		('106-06-06', 2468.74),
		('107-07-07', 1362.52),
		('108-08-08', 5153.82),
		('109-09-09', 9757.81);

insert into COMPANY(NAME, CITY, ECARD_ID, DESCRIPTION)
	values
		('First Company',	'Brest',	'100-00-00', 'This is First Company'),
		('Second Company',	'Minsk',	'101-01-01', 'This is First Company'),
		('Third Company',	'Homiel',	'102-02-02', 'This is First Company'),
		('Fourth Company',	'Brest',	'103-03-03', 'This is First Company'),
		('Fifth Company',	'Mogilev',	'104-04-04', 'This is First Company');


insert into CUSTOMER(NAME, CITY, ECARD_ID, BIRTHDAY)
	values
		('First Customer',	'Vitebsk',	'105-05-05', '1999-12-21'),
		('Second Customer', 'Brest',	'106-06-06', '2000-03-18'),
		('Third Customer',	'Mogilev',	'107-07-07', '1990-02-09'),
		('Fourth Customer', 'Minsk',	'108-08-08', '1996-09-11'),
		('Fifth Customer',	'Homiel',	'109-09-09', '1992-05-10');


insert into SERV(COMPANY_ID, COST, DESCRIPTION)
	values
		(1, 2900, 'Car technical repair'),
		(3, 19.99, 'Web-Server basic setup'),
		(5, 100, 'Draw a paint'),
		(1, 1500, 'Wheels replacement'),
		(4, 445, 'Clean the garden'),
		(4, 580, 'Clean the pool'),
		(2, 80, 'Organize a photo session'),
		(3, 50000, 'Build server security system');


insert into CONTRACT(SERVICE_ID, COMPANY_ID, CUSTOMER_ID, STATUS_ID, DATE)
	values
		(1, 1, 2, 1, GETDATE()),
		(3, 5, 3, 2, GETDATE()),
		(4, 1, 1, 1, GETDATE()),
		(6, 4, 4, 3, GETDATE()),
		(2, 3, 5, 1, GETDATE());

-------------------------------------------------------------------
--select * from COMPANY;
--select * from CUSTOMER;
--select * from ECARD;
--select * from CONTRACT;

--drop table CONTRACT;
--drop table SERV;
--drop table COMPANY;
--drop table CUSTOMER;
--drop table ECARD;
--drop table CONTRACT_STATUS;

--dbcc checkident ('CONTRACT', RESEED, 0);
--dbcc checkident ('SERV', RESEED, 0);
--dbcc checkident ('COMPANY', RESEED, 0);
--dbcc checkident ('CUSTOMER', RESEED, 0);
--dbcc checkident ('ECARD', RESEED, 0);
--dbcc checkident ('CONTRACT_STATUS', RESEED, 0);

--delete from CONTRACT;
--delete from SERV;
--delete from COMPANY;
--delete from CUSTOMER;
--delete from ECARD;
--delete from CONTRACT_STATUS;