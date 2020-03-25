CREATE TABLE [dbo].[survey_answer] (
    [suvey_answer_id] INT           IDENTITY (1, 1) NOT NULL,
    [suvey_id]        INT           NULL,
    [answer_id]       INT           NULL,
    [is_active]       BIT           DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [updated_on]      DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [created_by]      INT           NULL,
    [updated_by]      INT           NULL,
    [audit_client_id] INT           NULL,
    CONSTRAINT [PK_survey_answer_suvey_answer_id] PRIMARY KEY CLUSTERED ([suvey_answer_id] ASC),
    CONSTRAINT [FK_survey_answer_answer] FOREIGN KEY ([answer_id]) REFERENCES [dbo].[answer] ([answer_id]),
    CONSTRAINT [FK_survey_answer_survey] FOREIGN KEY ([suvey_id]) REFERENCES [dbo].[survey] ([survey_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.survey_answer', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'survey_answer';

