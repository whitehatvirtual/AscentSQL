CREATE TABLE [dbo].[survey_control] (
    [survey_control_id] INT            IDENTITY (1, 1) NOT NULL,
    [survey_id]         INT            NULL,
    [control_id]        INT            NULL,
    [answer_id]         INT            NULL,
    [comment]           NVARCHAR (MAX) NULL,
    [document_id]       INT            NULL,
    [calendar_date]     DATE           NULL,
    [is_active]         BIT            DEFAULT ((1)) NULL,
    [created_on]        DATETIME2 (7)  NULL,
    [updated_on]        DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]        INT            NULL,
    [updated_by]        INT            NULL,
    [audit_client_id]   INT            NULL,
    CONSTRAINT [PK_survey_control_survey_control_id] PRIMARY KEY CLUSTERED ([survey_control_id] ASC),
    CONSTRAINT [FK_survey_control_answer] FOREIGN KEY ([answer_id]) REFERENCES [dbo].[answer] ([answer_id]),
    CONSTRAINT [FK_survey_control_control] FOREIGN KEY ([control_id]) REFERENCES [dbo].[control] ([control_id]),
    CONSTRAINT [FK_survey_control_survey] FOREIGN KEY ([survey_id]) REFERENCES [dbo].[survey] ([survey_id]),
    CONSTRAINT [FK_survey_control_survey_control] FOREIGN KEY ([survey_control_id]) REFERENCES [dbo].[survey_control] ([survey_control_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.survey_control', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'survey_control';

