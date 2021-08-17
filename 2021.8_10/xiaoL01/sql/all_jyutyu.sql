 -- 派遣一元テーブルに挿入 (外注なし)
 INSERT INTO HAKKEN_ITIGEN (`HAKKEN_GETU`, `RENBAN`, `JYUTYU_NUM`, `TARGET_NUM`, `JYUTYU_STEP`, `DOC_NUM`, `TOUROKUBI`, `KOUSINNBI`)
 VALUES (?, 
 (select count(*) + 1 
     from HAKKEN_ITIGEN 
     where HAKKEN_GETU = ?), 
     ?, ?, ?, concat('DOC-HAKKEN_ITIGEN', ?), now(), now()
 );

-- 受注テーブルに挿入
 INSERT INTO JTYTYU (`JYUTYU_NUM`, `ANKENMEI`, `SAGYOU_BASYO`, `HAKKEN_SYURI`, 
 `WARI`, `KAISHIBI`, `SYURYOUBI`, `KINGAKU`, `IS_SEISAN`, `JYOUGEN_JIKAN`, 
 `KAGEN_JIKAN`, `JYOUGEN_KINGAKU`, `KAGEN_KINGAKU`, `SHIHARAI_SITE`, `BIKOU`, 
 `TOUROKUBI`, `KOUSINNBI`)
 VALUES (
 concat(?, '-', ?, '-', ?), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), now());

 -- 派遣一元テーブルに挿入 (外注あり)
  INSERT INTO HAKKEN_ITIGEN (`HAKKEN_GETU`, `RENBAN`, `JYUTYU_NUM`, `TARGET_NUM`, `GAITYU_NUM`, `JYUTYU_STEP`, `DOC_NUM`, `GAITYU_STEP`, `TOUROKUBI`, `KOUSINNBI`)
  VALUES (?, 
  (select count(*) + 1 
     from HAKKEN_ITIGEN 
     where HAKKEN_GETU = ?), 
     ?, ?, ?, ?, concat('DOC-HAKKEN_ITIGEN', ?), 0, now(), now()
  );
 
 -- 外注テーブルに挿入
INSERT INTO gaityu (`GAITYU_NUM`, `SAGYOUIN_ID`, `KEIYAKU_KAISYA`, `HAKKEN_SYURI`, `WARI`, `KAISHIBI`, `SYURYOUBI`, `KINGAKU`, `IS_SEISAN`, `JYOUGEN_JIKAN`, `KAGEN_JIKAN`, `JYOUGEN_KINGAKU`, `KAGEN_KINGAKU`, `SHIHARAI_SITE`, `BIKOU`, `TOUROKUBI`, `KOUSINNBI`)
 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), now());