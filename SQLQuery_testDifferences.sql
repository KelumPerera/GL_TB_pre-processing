SELECT 
	CAST(FirstSet.[G/Lacct] AS INT) 'GL_ACCT_NUMBER'
	,CAST(FirstSet.TBOB AS DECIMAL(19,2)) 'TBOB'
	,CAST(SecondSet.[G/Lacct1] AS INT) 'GL_ACCT_NUMBER1'
	,CAST(round(isnull(SecondSet.LedgerTxn,0),2) AS DECIMAL(19,2)) 'LedgerTxn'
	,CAST(FirstSet.TBCL AS DECIMAL(19,2)) 'TBCL'
	,CAST(round(isnull((FirstSet.TBOB + isnull(SecondSet.LedgerTxn,0)),0),2) AS DECIMAL(19,2)) 'CalcuCL'
	,CAST(round(((FirstSet.TBOB + isnull(SecondSet.LedgerTxn,0)) - FirstSet.TBCL),2) AS DECIMAL(19,2)) 'Diff'
FROM

(SELECT DISTINCT [AMW].[dbo].[AAWTB].[G/L acct] as 'G/Lacct' 
		,([AMW].[dbo].[AAWTB].[OP]) as 'TBOB'
		,([AMW].[dbo].[AAWTB].[CLBal]) as 'TBCL'
		FROM [AMW].[dbo].[AAWTB]
		full outer join [AMW].[dbo].[all_dataAAW]
		ON [AMW].[dbo].[AAWTB].[G/L acct] = [AMW].[dbo].[all_dataAAW].[GL_ACCT_NUMBER]
		) as FirstSet

FULL OUTER JOIN

(SELECT [AMW].[dbo].[AAWTB].[G/L acct] as 'G/Lacct1' ,isnull(SUM([AMW].[dbo].[all_dataAAW].[         AMOUNT]),0) as 'LedgerTxn'
		from [AMW].[dbo].[all_dataAAW]
		FULL Outer join [AMW].[dbo].[AAWTB]
		ON [AMW].[dbo].[all_dataAAW].[GL_ACCT_NUMBER] = [AMW].[dbo].[AAWTB].[G/L acct]
		WHERE [AMW].[dbo].[all_dataAAW].[DOCUMENT TYPE] NOT IN ('ZB' , 'DP', 'NI', 'PA' )
		group by [AMW].[dbo].[AAWTB].[G/L acct]
		) as SecondSet

ON FirstSet.[G/Lacct] = SecondSet.[G/Lacct1]
ORDER BY FirstSet.[G/Lacct];