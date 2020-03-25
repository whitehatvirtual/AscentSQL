CREATE TABLE [dbo].[risk] (
    [risk_id]         INT           IDENTITY (5, 1) NOT NULL,
    [risk_name]       VARCHAR (255) NOT NULL,
    [score]           INT           NOT NULL,
    [color]           VARCHAR (10)  DEFAULT (N'') NOT NULL,
    [is_active]       BIT           DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7) NULL,
    [updated_on]      DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [created_by]      INT           NULL,
    [updated_by]      INT           NULL,
    [audit_client_id] INT           NULL,
    CONSTRAINT [PK_risk_risk_id] PRIMARY KEY CLUSTERED ([risk_id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.risk', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'risk';

