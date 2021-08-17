drop table TORIHIKISAKI_MAIN;
create table TORIHIKISAKI_MAIN(
	TORIHIKI_ID int primary key AUTO_INCREMENT,
	TORIHIKI_NAME_ALL varchar(50) not null,
	TORIHIKI_NAME_RYAKU varchar(30) not null,
	YUUBIN varchar(8) not null,
	JYUSYO_1 varchar(100) not null,
	JYUSYO_2 varchar(100),
	TEL varchar(15),
	FAX varchar(15),
	URL varchar(100),
	BIKOU varchar(255),
	DELETE_FLAG int not null,
	TOUROKUBI DATETIME,
	KOUSINNBI DATETIME)
	default character set utf8 collate utf8_unicode_ci