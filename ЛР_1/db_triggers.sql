use SERVICE_PROVIDING;

create table CONTRACT_AUDITS(
	CHANGE_ID		int			identity	primary key,
	CONTRACT_ID		int			not null,
	SERVICE_ID		int			not null,
	COMPNAY_ID		int			not null,
	CUSTOMER_ID		int			not null,
	STATUS_ID		int			not null,
	CONTRACT_DATE	date		not null,
	UPDATED_AT		datetime	not null,
	OPERATION		char(3),
	check(OPERATION='INS' or OPERATION='DEL' or OPERATION='UPD')
);

create table SERV_AUDITS(
	CHANGE_ID		int				identity	primary key,
	SERV_ID			int				not null,
	COMPANY_ID		int				not null,
	COST			money			not null,
	DESCRIPTION		nvarchar(255)	not null,
	UPDATED_AT		datetime		not null,
	OPERATION		char(3),
	check(OPERATION='INS' or OPERATION='DEL')
);

select * from SERV_AUDITS;
select * from CONTRACT_AUDITS;

--------------------- Triggers ---------------------
create trigger CONTRACT_TRIGGER_INSERT_DELETE
on CONTRACT
after insert, delete
as
begin
	set nocount on;
	insert into CONTRACT_AUDITS(
		CONTRACT_ID,		
		SERVICE_ID,	
		COMPANY_ID,		
		CUSTOMER_ID,		
		STATUS_ID,		
		CONTRACT_DATE,	
		UPDATED_AT,		
		OPERATION
	)
	select 
		ins.ID,
		ins.SERVICE_ID,
		ins.COMPANY_ID,
		ins.CUSTOMER_ID,
		ins.STATUS_ID,
		ins.DATE,
		GETDATE(),
		'INS'
	from inserted ins
	union all
	select
		del.ID,
		del.SERVICE_ID,
		del.COMPANY_ID,
		del.CUSTOMER_ID,
		del.STATUS_ID,
		del.DATE,
		GETDATE(),
		'DEL'
	from deleted del;
end;

create trigger CONTRACT_TRIGGER_UPDATE_STATUS
on CONTRACT
after update
as
begin
	set nocount on;
	if UPDATE(STATUS_ID)
		begin
			insert into CONTRACT_AUDITS(
				CONTRACT_ID,		
				SERVICE_ID,	
				COMPANY_ID,		
				CUSTOMER_ID,		
				STATUS_ID,		
				CONTRACT_DATE,	
				UPDATED_AT,		
				OPERATION
			)
			select 
				ins.ID,
				ins.SERVICE_ID,
				ins.COMPANY_ID,
				ins.CUSTOMER_ID,
				ins.STATUS_ID,
				ins.DATE,
				GETDATE(),
				'UPD'
			from inserted ins
		end;
end;


create trigger SERV_TRIGGER_INSERT_DELETE
on SERV
after insert, delete
as
begin
	set nocount on;
	insert into SERV_AUDITS(
		SERV_ID,
		COMPANY_ID,
		COST,
		DESCRIPTION,
		UPDATED_AT,
		OPERATION
	)
	select
		ins.ID,
		ins.COMPANY_ID,
		ins.COST,
		ins.DESCRIPTION,
		GETDATE(),
		'INS'
	from inserted ins
	union all
	select
		del.ID,
		del.COMPANY_ID,
		del.COST,
		del.DESCRIPTION,
		GETDATE(),
		'DEL'
	from deleted del
end;
----------------------------------------------------

--exec ADD_SERVICE 2, 200, 'Testing triggers';
--exec DELETE_SERVICE_BY_ID 6;
--select * from COMPANY_SERVICES;
--select * from SERV_AUDITS;