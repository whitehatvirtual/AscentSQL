CREATE TABLE [dbo].[monthly_risk_score] (
    [monthly_risk_score_id] INT             IDENTITY (1, 1) NOT NULL,
    [client_id]             INT             NULL,
    [survey_id]             INT             NULL,
    [score]                 NUMERIC (10, 4) NULL,
    [score_month]           INT             NULL,
    [score_year]            INT             NULL,
    [calendar_date]         DATETIME2 (7)   NULL,
    CONSTRAINT [PK_monthly_risk_score] PRIMARY KEY CLUSTERED ([monthly_risk_score_id] ASC)
);

