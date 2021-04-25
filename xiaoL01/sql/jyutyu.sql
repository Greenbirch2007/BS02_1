drop table JYUTYU;
create table JYUTYU(
	JYUTYU_NUM varchar(30) primary key,
	ANKENMEI varchar(100) not null,
	SAGYOU_BASYO varchar(50) not null,
	HAKKEN_SYURI int not null,
	WARI FLOAT not null,
	KAISHIBI INT not null,
	SYURYOUBI INT not null,
	KINGAKU int	 not null,
	IS_SEISAN int(1) not null,
	JYOUGEN_JIKAN FLOAT,
	KAGEN_JIKAN FLOAT,
	JYOUGEN_KINGAKU int	,
	KAGEN_KINGAKU int,
	SHIHARAI_SITE int,
	BIKOU  varchar(255),
	TOUROKUBI DATETIME,
	KOUSINNBI DATETIME)
	default character set utf8 collate utf8_unicode_ci
	;