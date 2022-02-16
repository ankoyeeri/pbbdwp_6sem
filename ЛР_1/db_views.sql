use SERVICE_PROVIDING

----------------------- Views -------------------------
create view ECARDS_CUSTOMERS as
select cst.ID, cst.NAME, cst.CITY, cst.BRITHDAY, cst.ECARD_ID, ecd.BALANCE  
from CUSTOMER as cst join ECARD ecd on cst.ECARD_ID = ecd.ID;

--select * from ECARDS_CUSTOMERS;


create view ECARDS_COMPANIES as
select cmp.ID, cmp.NAME, cmp.CITY, cmp.DESCRIPTION, cmp.ECARD_ID, ecd.BALANCE 
from COMPANY as cmp join ECARD as ecd on cmp.ECARD_ID = ecd.ID;

--select * from ECARDS_COMPANIES;

create view COMPANY_SERVICES as
select 
	cmp.ID as COMPANY_ID, 
	cmp.NAME, 
	cmp.DESCRIPTION, 
	srv.ID AS SERV_ID, 
	srv.COST, 
	srv.DESCRIPTION as SERV_DESCRIPTION
from COMPANY as cmp join SERV as srv on cmp.ID = srv.COMPANY_ID;

--select * from COMPANY_SERVICES;

select * from CONTRACT_STATUS;
select * from CONTRACT;


create view CONTRACT_UNWRAP as
select 
	ctr.ID, 
	srv.DESCRIPTION as SERVICE_DESCRIPTION, 
	cmp.NAME as COMPANY_NAME, 
	cst.NAME as CUSTOMER_NAME,
	cstat.NAME as STATUS_NAME,
	ctr.DATE
from (((CONTRACT as ctr join SERV as srv
	on ctr.SERVICE_ID = srv.ID)	join COMPANY as cmp 
	on ctr.COMPANY_ID = cmp.ID)	join CUSTOMER as cst
	on ctr.CUSTOMER_ID = cst.ID) join CONTRACT_STATUS as cstat
	on ctr.STATUS_ID = cstat.ID

--select * from CONTRACT_UNWRAP;
--drop view CONTRACT_UNWRAP;
-------------------------------------------------------