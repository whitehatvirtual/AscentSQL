CREATE TABLE [dbo].[survey_calendar] (
    [survey_calendar_id]   INT           IDENTITY (1, 1) NOT NULL,
    [survey_calendar_date] INT           NULL,
    [control_id]           INT           NULL,
    [is_active]            BIT           DEFAULT ((1)) NULL,
    [created_on]           DATETIME2 (7) NULL,
    [updated_on]           DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [created_by]           INT           NULL,
    [updated_by]           INT           NULL,
    [audit_client_id]      INT           NULL,
    CONSTRAINT [PK_survey_calendar_survey_calendar_id] PRIMARY KEY CLUSTERED ([survey_calendar_id] ASC),
    CONSTRAINT [survey_calendar$survey_calendar_UNIQUE] UNIQUE NONCLUSTERED ([survey_calendar_id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.survey_calendar', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'survey_calendar';

