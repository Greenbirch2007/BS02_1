drop table HAKKEN_ITIGEN;
create table HAKKEN_ITIGEN(
	HAKKEN_GETU char(6),
	RENBAN int,
	JYUTYU_NUM varchar(30),
	TARGET_NUM varchar(30) not null,
	GAITYU_NUM varchar(30),
	-- SEIKYU_NUM varchar(30),
	DOC_NUM varchar(30),
	SAGYOU_JIKAN float,
	JYUTYU_STEP int,
	GAITYU_STEP int,
	TOUROKUBI DATETIME,
	KOUSINNBI DATETIME,
        primary key(HAKKEN_GETU,RENBAN))
	default character set utf8 collate utf8_unicode_ci
	;

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
	default character set utf8 collate utf8_unicode_ci;
    
drop table GAITYU;
create table GAITYU(
	GAITYU_NUM varchar(30) primary key ,
	SAGYOUIN_ID varchar(30) not null,
    KEIYAKU_KAISYA int not null,
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
