/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [JOURNAL_NUMBER]
      ,[DOCUMENT TYPE]
      ,[POSTING KEY]
      ,CAST([GL_ACCT_NUMBER] AS INT) 'GL_ACCT_NUMBER'
      ,[DESCRIPTION]
      ,[DEBIT CREDIT]
      ,CAST(round([         AMOUNT],2)AS DECIMAL(19,2)) 'AMOUNT'  -- Round the number to the 2nd decimal & format the output into a 2 decimal 
      ,CONVERT(varchar,[EFFECTIVE_DATE], 101) AS 'EFFECTIVE_DATE' -- Date format dd/mm/yyyy
      ,CONVERT(varchar,[ENTRY_DATE], 103) AS 'ENTRY_DATE'         -- Date format mm/dd/yyyy
      ,[PERIOD]
      ,[PREPARER_ID]
  FROM [AMW].[dbo].[all_dataAAW]
  WHERE [AMW].[dbo].[all_dataAAW].[DOCUMENT TYPE] NOT IN ('ZB' , 'DP', 'NI', 'PA' ) --Exclude memorandum JE's