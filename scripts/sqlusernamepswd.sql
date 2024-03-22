CREATE LOGIN onprem WITH PASSWORD = '123';

CREATE USER onprem FOR LOGIN onprem

SELECT name, is_disabled FROM sys.sql_logins;