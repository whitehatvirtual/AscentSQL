CREATE TABLE [dbo].[survey_client] (
    [survey_client]   INT           IDENTITY (1, 1) NOT NULL,
    [survey_id]       INT           NULL,
    [client_id]       INT           NULL,
    [is_active]       BIT           DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7) NULL,
    [updated_on]      DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [created_by]      INT           NULL,
    [updated_by]      INT           NULL,
    [audit_client_id] INT           NULL,
    CONSTRAINT [PK_survey_client_survey_client] PRIMARY KEY CLUSTERED ([survey_client] ASC),
    CONSTRAINT [FK_survey_client_client] FOREIGN KEY ([client_id]) REFERENCES [dbo].[client] ([client_id]),
    CONSTRAINT [FK_survey_client_survey] FOREIGN KEY ([survey_id]) REFERENCES [dbo].[survey] ([survey_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.survey_client', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'survey_client';

