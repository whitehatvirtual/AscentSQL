CREATE TABLE [dbo].[survey_control_history] (
    [survey_control_history_id] INT            IDENTITY (1, 1) NOT NULL,
    [survey_control_id]         INT            NULL,
    [answer_id]                 INT            NULL,
    [comment]                   NVARCHAR (MAX) NULL,
    [is_active]                 BIT            DEFAULT ((1)) NULL,
    [created_on]                DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [updated_on]                DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]                INT            NULL,
    [updated_by]                INT            NULL,
    [audit_client_id]           INT            NULL,
    CONSTRAINT [PK_survey_control_history_survey_control_history_id] PRIMARY KEY CLUSTERED ([survey_control_history_id] ASC),
    CONSTRAINT [FK_survey_control_history_answer] FOREIGN KEY ([answer_id]) REFERENCES [dbo].[answer] ([answer_id]),
    CONSTRAINT [FK_survey_control_history_survey_control] FOREIGN KEY ([survey_control_id]) REFERENCES [dbo].[survey_control] ([survey_control_id])
);

