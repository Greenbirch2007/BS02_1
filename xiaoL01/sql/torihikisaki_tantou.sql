drop table TORIHIKISAKI_TANTOU;
create table TORIHIKISAKI_TANTOU(
	TANTOU_ID int primary key AUTO_INCREMENT,
	TORIHIKI_ID int,
	FIRST_NAME varchar(20) not null,
	LAST_NAME varchar(20) not null,
	SYOZOKU varchar(50),
	YAKUSYOKU varchar(50),
	MAIL varchar(100),
	TEL varchar(15),
	JIMU_MAIL int,
	BIKOU  varchar(255))
	default character set utf8 collate utf8_unicode_ci