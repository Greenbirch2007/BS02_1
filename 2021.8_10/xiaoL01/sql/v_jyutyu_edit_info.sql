drop view V_JYUTYU_EDIT_INFO;

create view V_JYUTYU_EDIT_INFO(JYUTYU_NUM, JYUTYU_STEP, IRAISAKI_NM, IRAISAKI_ID, SYAIN_NM, SYAIN_ID, 
ANKENMEI, SAGYOU_BASYO, HAKKEN_SYURI, JYUTYU_WARI, JYUTYU_KAISHIBI, JYUTYU_SYURYOUBI, 
JYUTYU_KINGAKU, JYUTYU_IS_SEISAN, JYUTYU_JYOUGEN_JIKAN, JYUTYU_KAGEN_JIKAN, 
JYUTYU_JYOUGEN_KINGAKU, JYUTYU_KAGEN_KINGAKU, JYUTYU_SHIHARAI_SITE, JYUTYU_BIKOU, 
GAITYUSAKI_NM, GAITYUSAKI_ID, GAITYU_SYAIN_ID, SAGYOIN_NM, GAITYU_HAKKEN_SYURI, GAITYU_HAKKEN_KAISYA, GAITYU_WARI, GAITYU_KAISHIBI,
GAITYU_SYURYOUBI, GAITYU_KINGAKU, GAITYU_IS_SEISAN, GAITYU_JYOUGEN_JIKAN,
GAITYU_KAGEN_JIKAN, GAITYU_JYOUGEN_KINGAKU, GAITYU_KAGEN_KINGAKU, GAITYU_SHIHARAI_SITE,
GAITYU_BIKOU, IS_GAITYU, HAKKEN_GETU, RENBAN)
as
select 
 A.JYUTYU_NUM,
 A.JYUTYU_STEP, -- ADD
 (select TORIHIKI_NAME_ALL
    from TORIHIKISAKI_MAIN
   where CAST(SUBSTRING( A.JYUTYU_NUM,1,4) AS SIGNED) = TORIHIKI_ID
  ) as IRAISAKI_NM,
  SUBSTRING( A.JYUTYU_NUM,1,4) as IRAISAKI_ID,
-- A.TARGET_SYURI,
-- A.TARGET_NUM,
 /*(case when A.TARGET_SYURI = 3 then null*/
 (case when A.GAITYU_NUM is not null then null
       else
            (select CONCAT(FIRST_NAME_KANJI,' ',LAST_NAME_KANJI)
             from SYAIN_MAIN
             where CAST(A.TARGET_NUM AS SIGNED) = SYAIN_ID
            )
  end) as SYAIN_NM,
  CAST(A.TARGET_NUM AS SIGNED) as SYAIN_ID,
 B.ANKENMEI,
 B.SAGYOU_BASYO,
 B.HAKKEN_SYURI,
 B.WARI as JYUTYU_WARI,
 B.KAISHIBI as JYUTYU_KAISHIBI,
 B.SYURYOUBI as JYUTYU_SYURYOUBI,
 B.KINGAKU as JYUTYU_KINGAKU,
 B.IS_SEISAN as JYUTYU_IS_SEISAN,
 B.JYOUGEN_JIKAN as JYUTYU_JYOUGEN_JIKAN,
 B.KAGEN_JIKAN as JYUTYU_KAGEN_JIKAN,
 B.JYOUGEN_KINGAKU as JYUTYU_JYOUGEN_KINGAKU,
 B.KAGEN_KINGAKU as JYUTYU_KAGEN_KINGAKU,
 B.SHIHARAI_SITE as JYUTYU_SHIHARAI_SITE,
 B.BIKOU as JYUTYU_BIKOU,
 /*(case when A.TARGET_SYURI = 3 then*/
  (case when A.GAITYU_NUM is not null then
	-- 外注会社
	(case when SUBSTRING( A.TARGET_NUM,1,4) != '0000'
		then (select TORIHIKI_NAME_RYAKU
                    from TORIHIKISAKI_MAIN
                    where CAST(SUBSTRING( A.TARGET_NUM,1,4) AS SIGNED) = TORIHIKI_ID
                   )
	-- 個人事業主
	 else ( select CONCAT(FIRST_NAME_KANJI,' ',LAST_NAME_KANJI) 
			from syain_main
            where CAST(SUBSTRING( A.TARGET_NUM, 6) AS SIGNED) = SYAIN_ID
     )
     end
  )
       else null
  end) as GAITYUSAKI_NM,
  (case when A.GAITYU_NUM is not null then 
		(case when SUBSTRING( A.TARGET_NUM,1,4) != '0000' then SUBSTRING( A.TARGET_NUM,1,4)
			else null
			end)
		else null
        end
        ) as GAITYUSAKI_ID,
  (case when A.GAITYU_NUM is not null then 
		(case when SUBSTRING( A.TARGET_NUM,1,4) = '0000' then SUBSTRING( A.TARGET_NUM, 6)
			else null
			end)
		else null
        end
        ) as GAITYU_SYAIN_ID,
 /*(case when A.TARGET_SYURI = 3  then SUBSTRING( A.TARGET_NUM,6)*/
 -- 外注会社がありのみ、作業員名が有効
 (case when A.GAITYU_NUM is not null then
	(case when SUBSTRING( A.TARGET_NUM,1,4) != '0000' 
		then SUBSTRING( A.TARGET_NUM,6)
	else null
    end)
       else null
  end) as SAGYOIN_NM,
 C.HAKKEN_SYURI as GAITYU_HAKKEN_SYURI,
 C.KEIYAKU_KAISYA as GAITYU_HAKKEN_KAISYA,
 C.WARI as GAITYU_WARI,
 C.KAISHIBI as GAITYU_KAISHIBI,
 C.SYURYOUBI as GAITYU_SYURYOUBI,
 C.KINGAKU as GAITYU_KINGAKU,
 C.IS_SEISAN as GAITYU_IS_SEISAN,
 C.JYOUGEN_JIKAN as GAITYU_JYOUGEN_JIKAN,
 C.KAGEN_JIKAN as GAITYU_KAGEN_JIKAN,
 C.JYOUGEN_KINGAKU as GAITYU_JYOUGEN_KINGAKU,
 C.KAGEN_KINGAKU as GAITYU_KAGEN_KINGAKU,
 C.SHIHARAI_SITE as GAITYU_SHIHARAI_SITE,
 C.BIKOU as GAITYU_BIKOU,
 (case when A.GAITYU_NUM is not null then 1 else 0 end) as IS_GAITYU,
  A.HAKKEN_GETU, -- ADD
  A.RENBAN -- ADD
 from HAKKEN_ITIGEN A
 inner join JYUTYU B
 on A.JYUTYU_NUM = B.JYUTYU_NUM
 left join GAITYU C
 on A.GAITYU_NUM = C.GAITYU_NUM;
-- where A.HAKKEN_GETU = '受注月'
--  and A.RENBAN = '連番';

 select JYUTYU_NUM, JYUTYU_STEP, IRAISAKI_NM, IRAISAKI_ID, SYAIN_NM, SYAIN_ID,
ANKENMEI, SAGYOU_BASYO, HAKKEN_SYURI, JYUTYU_WARI, JYUTYU_KAISHIBI, JYUTYU_SYURYOUBI, 
JYUTYU_KINGAKU, JYUTYU_IS_SEISAN, JYUTYU_JYOUGEN_JIKAN, JYUTYU_KAGEN_JIKAN, 
JYUTYU_JYOUGEN_KINGAKU, JYUTYU_KAGEN_KINGAKU, JYUTYU_SHIHARAI_SITE, JYUTYU_BIKOU, 
GAITYUSAKI_NM, GAITYUSAKI_ID, GAITYU_SYAIN_ID, SAGYOIN_NM, GAITYU_HAKKEN_SYURI, GAITYU_HAKKEN_KAISYA, GAITYU_WARI, GAITYU_KAISHIBI,
GAITYU_SYURYOUBI, GAITYU_KINGAKU, GAITYU_IS_SEISAN, GAITYU_JYOUGEN_JIKAN,
GAITYU_KAGEN_JIKAN, GAITYU_JYOUGEN_KINGAKU, GAITYU_KAGEN_KINGAKU, GAITYU_SHIHARAI_SITE,
GAITYU_BIKOU, IS_GAITYU, HAKKEN_GETU, RENBAN
 from V_JYUTYU_EDIT_INFO
-- where HAKKEN_GETU = '201712'
--  and RENBAN = 6;