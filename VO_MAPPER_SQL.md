# vo mybatis mapper sql문

- 수정자 : 최상용
- 수정일 : 2018-05-29
- 적용방법 :
  - DB툴에서 TABLE_NAME 수정하고 실행 후 필요한 컬럼 복사해서 사용
  - 데이터 길이가 길다고 실행오류가 나는 경우 조건절에 COLUMN_ID 1~20정도로 범위를 좁혀서 적용
  - TABLE_NAME : 테이블명
  - VO_INFO : VO 파일에 적용
  - CELLCLICK : JSP화면에서 그리드와 폼 연결
  - INS_INFO : INSERT 구문
  - INS_VAL : INSERT 구문
  - UPD_VAL : UPDATE 구문
  - PK_COL : PK 컬럼(업데이트시 참고)
   
- 변경내용
  - CELLCLICK 추가

```sql
SELECT  A.TABLE_NAME
        ,LISTAGG('private String ' || REPLACE(SUBSTR(LOWER(A.COLUMN_NAME), 1, 1) || SUBSTR(INITCAP(A.COLUMN_NAME), 2, LENGTH(A.COLUMN_NAME)), '_', '') || ';' || '			/* ' || B.COMMENTS || ' */' || CHR(10)) WITHIN GROUP(ORDER BY A.COLUMN_ID) AS VO_INFO
        ,LISTAGG('$("#' || REPLACE(SUBSTR(LOWER(A.COLUMN_NAME), 1, 1) || SUBSTR(INITCAP(A.COLUMN_NAME), 2, LENGTH(A.COLUMN_NAME)), '_', '') || '").val(event.item.' || REPLACE(SUBSTR(LOWER(A.COLUMN_NAME), 1, 1) || SUBSTR(INITCAP(A.COLUMN_NAME), 2, LENGTH(A.COLUMN_NAME)), '_', '') || ');' || CHR(10)) WITHIN GROUP(ORDER BY A.COLUMN_ID) AS CELLCLICK 
        ,'INSERT INTO ' || A.TABLE_NAME || '(' || CHR(10) || LISTAGG(A.COLUMN_NAME, CHR(10) || ',') WITHIN GROUP(ORDER BY A.COLUMN_ID) || CHR(10) || ')' AS INS_INFO
        ,LISTAGG('#{' || REPLACE(SUBSTR(LOWER(A.COLUMN_NAME), 1, 1) || SUBSTR(INITCAP(A.COLUMN_NAME), 2, LENGTH(A.COLUMN_NAME)), '_', '') || '}', CHR(10) || ', ') WITHIN GROUP(ORDER BY A.COLUMN_ID) AS INS_VAL
        ,LISTAGG(A.COLUMN_NAME || ' = #{' || REPLACE(SUBSTR(LOWER(A.COLUMN_NAME), 1, 1) || SUBSTR(INITCAP(A.COLUMN_NAME), 2, LENGTH(A.COLUMN_NAME)), '_', '') || '}', CHR(10) || ', ') WITHIN GROUP(ORDER BY A.COLUMN_ID) AS UPD_VAL
        ,(
            SELECT LISTAGG(XA.COLUMN_NAME, ', ') WITHIN GROUP(ORDER BY XA.POSITION)
            FROM USER_CONS_COLUMNS XA
            JOIN USER_CONSTRAINTS XB ON XA.CONSTRAINT_NAME = XB.CONSTRAINT_NAME
            WHERE   XB.CONSTRAINT_TYPE = 'P'
                AND XB.TABLE_NAME = A.TABLE_NAME
            GROUP BY XB.TABLE_NAME
        ) AS PK_COL
FROM ALL_TAB_COLUMNS A,  ALL_COL_COMMENTS B
WHERE   A.COLUMN_NAME = B.COLUMN_NAME
    AND A.TABLE_NAME = B.TABLE_NAME
    AND A.OWNER = 'CM_ENF_USER'
    AND B.OWNER = 'CM_ENF_USER'
    AND A.TABLE_NAME = 'SY_USER'
    --AND A.COLUMN_ID BETWEEN 1 AND 20
GROUP BY A.TABLE_NAME;
```