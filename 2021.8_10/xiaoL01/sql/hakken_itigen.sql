drop table HAKKEN_ITIGEN;
create table HAKKEN_ITIGEN(
	HAKKEN_GETU char(6),
	RENBAN int,
	JYUTYU_NUM varchar(30),
	TARGET_SYURI int,
	TARGET_NUM varchar(30),
	GAITYU_NUM varchar(30),
	SEIKYU_NUM varchar(30),
	DOC_NUM varchar(30),
	SYURYOUBI DATE not null,
	JYUTYU_STEP int not null,
	GAITYU_STEP int not null,
	TOUROKUBI DATETIME,
	KOUSINNBI DATETIME,
        primary key(HAKKEN_GETU,RENBAN))
	default character set utf8 collate utf8_unicode_ci
	;