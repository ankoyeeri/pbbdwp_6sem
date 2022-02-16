use SERVICE_PROVIDING;
USE SERVICE_PROVIDING;

----------------------- Indexes ----------------------- 
create index INDEX_NAME
on COMPANY (NAME);

create index INDEX_NAME
on CUSTOMER (NAME);

create index INDEX_COST
on SERV (COST);
-------------------------------------------------------
--drop index COMPANY.INDEX_NAME;
--drop index CUSTOMER.INDEX_NAME;
--drop index SERV.INDEX_COST;