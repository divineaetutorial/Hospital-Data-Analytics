CREATE VIEW bronze.procedures AS 
SELECT * 
FROM read_csv_auto('https://docs.google.com/spreadsheets/d/e/2PACX-1vT2uIIwWMIZWMPTp9Z5cBiBO-hlNXPpq8Fz1vG9zuhVYzMYghBEsheZa0Qihz0VORBW--7AOui2l9Rj/pub?gid=1907204473&single=true&output=csv', ("header" = CAST('t' AS BOOLEAN)));