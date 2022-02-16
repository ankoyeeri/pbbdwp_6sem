use SERVICE_PROVIDING;

----------------------- Functions ----------------------- 
create or alter function GetCompanyServicesCost(@company_id int)
	returns money
as
begin
	if @company_id is null
		begin
			return -1;
		end;
	declare @result money;
	select @result=sum(cast(COST as money)) from COMPANY_SERVICES where COMPANY_ID=@company_id;
	return @result;
end;


create or alter function GetUsersSumByCity(@city nvarchar(50))
	returns int
as
begin
	declare @result int;
	select @result=count(*) from CUSTOMER where CITY=@city;
	return @result;
end;

create or alter function GetEcardBalancesSum()
	returns money
as
begin
	declare @result money;
	select @result=sum(cast(BALANCE as money)) from ECARD;
	return @result;
end;


---------------------------------------------------------
--select * from CUSTOMER;
--select * from ECARD;
--insert into ECARD values('121-12-21', 4200.01);
--insert into CUSTOMER(NAME, CITY, BIRTHDAY, ECARD_ID) \
--	values('Test Customer', 'Minsk', '01.01.2000', '121-12-21');


--go
--	declare @ret money;
--	exec @ret=dbo.GetCompanyServicesCost @company_id=2;
--	select @ret;


--go
--	declare @ret int;
--	exec @ret=dbo.GetUsersSumByCity @city='Minsk';
--	select @ret;


--go
--	declare @res money;
--	exec @res=dbo.GetEcardBalancesSum;
--	select * from ECARD;
--	select @res;

--drop function GetCompanyServicesCost;
--drop function GetUsersSumByCity;
--drop function GetEcardBalancesSum;