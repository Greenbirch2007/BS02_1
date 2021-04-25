drop table SYAIN_RIREKI;
create table SYAIN_RIREKI(
	SYAIN_ID int not null,
	KAISIBI DATE not null,
	SYURYOBI DATE,
	KAISYA_NAME VARCHAR(100),
	BUSYO VARCHAR(100),
	TOUROKUBI DATETIME,
	KOUSINNBI DATETIME,
        primary key(SYAIN_ID,KAISIBI))
	default character set utf8 collate utf8_unicode_ci
	;