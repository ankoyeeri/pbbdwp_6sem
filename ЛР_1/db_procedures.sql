use SERVICE_PROVIDING;

----------------------- Procedures -----------------------
create procedure ADD_SERVICE 
		@company_id int,
		@cost money,
		@description nvarchar(255)
as
begin
	if @company_id is not null
		insert into SERV(COMPANY_ID, COST, DESCRIPTION) 
			values(@company_id, @cost, @description)
	else
		print N'Company ID is null';
end;



create procedure DELETE_SERVICE_BY_ID
	@service_id int
as
begin
	if @service_id is not null
		delete from SERV where ID=@service_id;
	else
		print N'Service ID is null';
end;


create procedure UPDATE_SERVICE_BY_ID
	@service_id int,
	@company_id int,
	@cost money,
	@description nvarchar(255)
as
begin
	if @service_id is null
		begin
			print N'Service ID is null'
			return 0;
		end;
	update SERV
	set 
		COMPANY_ID=ISNULL(@company_id, COMPANY_ID),
		COST=ISNULL(@cost, COST),
		DESCRIPTION=ISNULL(@description, DESCRIPTION)
	where ID=@service_id;
end;


-------------------------------------------------------
--dbcc checkident ('SERV', RESEED, 0);
--delete from SERV;

--select * from ECARD;
--select * from COMPANY;
--insert into ECARD values ('123-12-12', 2000);
--insert into COMPANY(NAME, CITY, DESCRIPTION, ECARD_ID) values('Test Company', 'Minsk', 'This is a test company', '123-12-12');
--delete from ECARD where BALANCE=2000;


--exec ADD_SERVICE @company_id=2, @cost=1599, @description='Test service';
--drop procedure ADD_SERVICE;


--exec DELETE_SERVICE_BY_ID @service_id=3;
--drop procedure DELETE_SERVICE_BY_ID;

--exec UPDATE_SERVICE_BY_ID 
--	@service_id=4, 
--	@company_id=null, 
--	@cost=159.99, 
--	@description='Updated description';
--drop procedure UPDATE_SERVICE_BY_ID;