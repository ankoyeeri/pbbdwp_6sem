use master;
go

exec sp_configure 'clr enabled', 1;
go
reconfigure;
go