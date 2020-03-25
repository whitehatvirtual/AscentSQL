CREATE TABLE [dbo].[survey_control_note] (
    [survey_control_note_id] INT           IDENTITY (1, 1) NOT NULL,
    [survey_control_id]      INT           NULL,
    [note_id]                INT           NULL,
    [is_active]              BIT           DEFAULT ((1)) NULL,
    [created_on]             DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [updated_on]             DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [created_by]             INT           NULL,
    [updated_by]             INT           NULL,
    [audit_client_id]        INT           NULL,
    CONSTRAINT [PK_survey_control_note_survey_control_note_id] PRIMARY KEY CLUSTERED ([survey_control_note_id] ASC),
    CONSTRAINT [FK_survey_control_note_note] FOREIGN KEY ([note_id]) REFERENCES [dbo].[note] ([note_id]),
    CONSTRAINT [FK_survey_control_note_survey_control] FOREIGN KEY ([survey_control_id]) REFERENCES [dbo].[survey_control] ([survey_control_id])
);

