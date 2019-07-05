--QUESTAO N.01
SELECT  NOME_MUN, NOME_UF, MES_ANO_ACIDENTE, (CAST((NUM_ACID*100000/POPULAÇÃO) AS NUMERIC (9,2))) AS NUM_CEM  FROM
(SELECT MES_ANO_ACIDENTE, MUNIC_EMPREGADOR, COUNT(TIPO_DO_ACIDENTE) AS NUM_ACID FROM 
DUNCANBDA.ACID_TRAB_2018JUL_2019MAR_9 GROUP BY MUNIC_EMPREGADOR, MES_ANO_ACIDENTE)
JOIN (SELECT MUNICIPIOS.NOME_UF, POPULAÇÃO, MUNICIPIOS_POPULACOES.MUNICÍPIO AS NOME_MUN, MUNICIPIOS_POPULACOES.COD_MUNIC
FROM DUNCANBDA.MUNICIPIOS_POPULACOES
JOIN DUNCANBDA.MUNICIPIOS ON MUNICIPIOS_POPULACOES.COD_MUNIC = MUNICIPIOS.COD_MUNIC) ON MUNIC_EMPREGADOR = COD_MUNIC
ORDER BY NUM_CEM DESC;

--QUESTAO N.02
SELECT AGENTE_CAUSADOR_ACIDENTE, MES_ANO_ACIDENTE,  COUNT(*) "NUMERO_ACIDENTES"
FROM DUNCANBDA.ACID_TRAB_2018JUL_2019MAR_9 
GROUP BY MES_ANO_ACIDENTE, AGENTE_CAUSADOR_ACIDENTE, MES_ANO_ACIDENTE, INDICA_OBITO_ACIDENTE
HAVING INDICA_OBITO_ACIDENTE = 'Sim' and (COUNT(*)> 2);

--QUESTAO N.03
SELECT DESC_OCUPACAO, MES_ANO_ACIDENTE, NUMERO_ACIDENTES 
FROM (SELECT MES_ANO_ACIDENTE, CBO, COUNT(*) "NUMERO_ACIDENTES"
FROM DUNCANBDA.ACID_TRAB_2018JUL_2019MAR_9 
GROUP BY MES_ANO_ACIDENTE, CBO) "TAB_1" 
JOIN DUNCANBDA.CBO2002_OCUPACAO "TAB_2" 
ON TAB_1.CBO=TAB_2.OCUPACAO
ORDER BY NUMERO_ACIDENTES DESC;

--QUESTAO N. 04
SELECT CNAE20_GRUPOS.DENOMINACAO, ACID_TRAB_2018JUL_2019MAR_9.MES_ANO_ACIDENTE, COUNT(ACID_TRAB_2018JUL_2019MAR_9.MES_ANO_ACIDENTE) AS TOTAL_ACID
FROM (DUNCANBDA.ACID_TRAB_2018JUL_2019MAR_9
JOIN DUNCANBDA.CNAE20_CLASSES ON ACID_TRAB_2018JUL_2019MAR_9.CNAE20_EMPREGADOR = CNAE20_CLASSES.CLASSE_NUM)
JOIN DUNCANBDA.CNAE20_GRUPOS ON CNAE20_CLASSES.GRUPO = CNAE20_GRUPOS.GRUPO
GROUP BY CNAE20_GRUPOS.DENOMINACAO, ACID_TRAB_2018JUL_2019MAR_9.MES_ANO_ACIDENTE
HAVING (COUNT(ACID_TRAB_2018JUL_2019MAR_9.MES_ANO_ACIDENTE) > 1)
ORDER BY TOTAL_ACID DESC;

--QUESTAO N. 05
SELECT NATUREZA_DA_LESAO, COUNT(NATUREZA_DA_LESAO) AS ACID_POR_LESAO FROM DUNCANBDA.ACID_TRAB_2018JUL_2019MAR_9
GROUP BY NATUREZA_DA_LESAO
HAVING (COUNT(NATUREZA_DA_LESAO) > 100);