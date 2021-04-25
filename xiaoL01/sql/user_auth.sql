drop table USER_AUTH;
create table USER_AUTH(
	USER_ID VARCHAR(20),
	USER_NAME VARCHAR(30),
	PASSWORD VARCHAR(15),
	USER_ROLE CHAR(1),
        primary key(USER_ID))
	default character set utf8 collate utf8_unicode_ci;
    
INSERT USER_AUTH VALUE('S001','管理　太郎','S001','S');
INSERT USER_AUTH VALUE('S002','管理　花子','S002','S');
INSERT USER_AUTH VALUE('A001','統合　花子','A001','A');
INSERT USER_AUTH VALUE('A002','統合　太郎','A002','A');
INSERT USER_AUTH VALUE('B001','営業　花子','B001','B');
INSERT USER_AUTH VALUE('B002','営業　太郎','B002','B');
INSERT USER_AUTH VALUE('C001','経理　花子','C001','C');
INSERT USER_AUTH VALUE('C002','経理　太郎','C002','C');
INSERT USER_AUTH VALUE('D001','人事　花子','D001','D');
INSERT USER_AUTH VALUE('D002','人事　太郎','D002','D');