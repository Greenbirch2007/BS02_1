drop table GAITYU;
create table GAITYU(
	GAITYU_NUM varchar(30) primary key ,
	SAGYOUIN_ID varchar(30),
	HAKKEN_SYURI int not null,
	WARI FLOAT not null,
	KAISHIBI int not null,
	SYURYOUBI int not null,
	KINGAKU int not null,
	IS_SEISAN int(1) not null,
	JYOUGEN_JIKAN FLOAT,
	KAGEN_JIKAN FLOAT,
	JYOUGEN_KINGAKU int,
	KAGEN_KINGAKU int,
	SHIHARAI_SITE int,
	BIKOU  varchar(255),
	TOUROKUBI DATETIME,
	KOUSINNBI DATETIME)
	default character set utf8 collate utf8_unicode_ci
	;