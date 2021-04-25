drop view V_JYUTYU_MANAGE;

create view V_JYUTYU_MANAGE(IRAISAKI_NM, JYUTYU_NUM, TARGET_NM, JYUTYU_KINGAKU, 
JYUTYU_SEISAN, GAITYU_NUM, GAITYU_KINGAKU, GAITYU_SEISAN, JYUTYU_STEP, IS_ENTYO, HAKKEN_GETU, RENBAN)
as
select 
-- 受注先(受注なしなら'')
 (case when A.JYUTYU_NUM is null then ''
       else (select TORIHIKI_NAME_RYAKU
             from TORIHIKISAKI_MAIN
             where CAST(SUBSTRING( A.JYUTYU_NUM,1,4) AS SIGNED) = TORIHIKI_ID
            )
  end) as IRAISAKI_NM,
  -- 受注番号
  A.JYUTYU_NUM,
  -- 作業員名
  -- * 自社社員 -> 社員名
  -- * 外注先は個人事業主 -> 個人事業主 社員名
  -- * 外注先はほかの会社の社員 -> 会社名 社員名
 (case when A.GAITYU_NUM is null then 
            (select CONCAT(FIRST_NAME_KANJI,' ',LAST_NAME_KANJI)
               from SYAIN_MAIN
              where CAST(A.TARGET_NUM AS SIGNED) = SYAIN_ID
            )
       else
           case when SUBSTRING(A.TARGET_NUM,1,4) = '0000' then
                concat('個人事業主',
                       -- CHAR(10),
                       '@@',
                       (select CONCAT(FIRST_NAME_KANJI,' ',LAST_NAME_KANJI)
                         from SYAIN_MAIN
                        where CAST(SUBSTRING( A.TARGET_NUM,6) AS SIGNED) = SYAIN_ID
                       )
                      )
           else
				concat(
                        (select TORIHIKI_NAME_RYAKU
                          from TORIHIKISAKI_MAIN
                         where CAST(SUBSTRING( A.TARGET_NUM,1,4) AS SIGNED) = TORIHIKI_ID
                        ),
                        -- CHAR(10),
                        '@@',
                        SUBSTRING( A.TARGET_NUM,6)
					)
           end
  end) as TARGET_NM,
 (case when A.JYUTYU_NUM is null then ''
       else concat("\¥",format(B.KINGAKU ,0))
  end) as JYUTYU_KINGAKU,
 (case when A.JYUTYU_NUM is null then ''
       when B.IS_SEISAN = 0 then '固定'
       else concat(B.KAGEN_JIKAN,'H～',B.JYOUGEN_JIKAN,'H',
					-- CHAR(10),
                    '@@',
                   '(',concat("\¥",format(B.KAGEN_KINGAKU ,0)),'～',concat("\¥",format(B.JYOUGEN_KINGAKU ,0)),')'
                  )
  end) as JYUTYU_SEISAN,
  -- 外注番号
 (case when A.JYUTYU_NUM is null then ''
       when C.GAITYU_NUM is null then ''
       else C.GAITYU_NUM
  end) as GAITYU_NUM,
 (case when A.JYUTYU_NUM is null then ''
       when C.GAITYU_NUM is null then ''
       else concat("\¥",format(C.KINGAKU ,0))
  end) as GAITYU_KINGAKU,
 (case when A.JYUTYU_NUM is null then ''
       when C.GAITYU_NUM is null then ''
       when C.IS_SEISAN = 0 then '固定'
       else concat(concat("\¥",format(C.KAGEN_KINGAKU ,0)),'～',concat("\¥",format(C.JYOUGEN_KINGAKU ,0)))
  end) as GAITYU_SEISAN,
  A.JYUTYU_STEP,
 (case when (select count(*)
               from HAKKEN_ITIGEN 
              where A.TARGET_NUM = TARGET_NUM
                -- and HAKKEN_GETU = DATE_ADD(str_to_date( A.HAKKEN_GETU, '%Y%M'),INTERVAL 1 MONTH)
                and HAKKEN_GETU = date_format(date_add(str_to_date(concat(A.HAKKEN_GETU, '01'), '%Y%m%d'), INTERVAL 1 MONTH), '%Y%m')
                and JYUTYU_STEP >= 2
            ) = 0 and A.JYUTYU_STEP >= 2
       then 1
       else 0
  end) as IS_ENTYO,
  A.HAKKEN_GETU,
  A.RENBAN
 from HAKKEN_ITIGEN A
 left join JYUTYU B
 on A.JYUTYU_NUM = B.JYUTYU_NUM
 left join GAITYU C
 on A.GAITYU_NUM = C.GAITYU_NUM;
 
 select IRAISAKI_NM, JYUTYU_NUM, TARGET_NM, JYUTYU_KINGAKU, JYUTYU_SEISAN, 
 GAITYU_NUM, GAITYU_KINGAKU, GAITYU_SEISAN, JYUTYU_STEP, IS_ENTYO, HAKKEN_GETU, RENBAN
 from V_JYUTYU_MANAGE A
 where HAKKEN_GETU = '201801'
 order by JYUTYU_NUM;
 
 