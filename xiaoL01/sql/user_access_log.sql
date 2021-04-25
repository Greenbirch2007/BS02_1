drop table USER_ACCESS_LOG;
create table USER_ACCESS_LOG(
	ID int primary key AUTO_INCREMENT,
	USER_ID VARCHAR(20),
	GAMEN_ID VARCHAR(30),
	START_TIME DATETIME)
	default character set utf8 collate utf8_unicode_ci
	;  