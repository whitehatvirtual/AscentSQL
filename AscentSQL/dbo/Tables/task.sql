CREATE TABLE [dbo].[task] (
    [task_id]           INT            IDENTITY (1, 1) NOT NULL,
    [survey_id]         INT            NULL,
    [task_name]         NVARCHAR (255) NULL,
    [description]       NVARCHAR (MAX) NULL,
    [type_id]           INT            NULL,
    [client_id]         INT            NULL,
    [user_id]           INT            NULL,
    [survey_control_id] INT            NULL,
    [document_id]       INT            NULL,
    [answer_id]         INT            NULL,
    [calendar_date]     DATETIME2 (7)  NULL,
    [is_active]         BIT            DEFAULT ((1)) NULL,
    [created_on]        DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [updated_on]        DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]        INT            NULL,
    [updated_by]        INT            NULL,
    [audit_client_id]   INT            NULL,
    CONSTRAINT [PK_task_task_id] PRIMARY KEY CLUSTERED ([task_id] ASC),
    CONSTRAINT [FK_task_client] FOREIGN KEY ([client_id]) REFERENCES [dbo].[client] ([client_id]),
    CONSTRAINT [FK_task_survey] FOREIGN KEY ([survey_id]) REFERENCES [dbo].[survey] ([survey_id]),
    CONSTRAINT [FK_task_survey_control] FOREIGN KEY ([survey_control_id]) REFERENCES [dbo].[survey_control] ([survey_control_id]),
    CONSTRAINT [FK_task_type] FOREIGN KEY ([type_id]) REFERENCES [dbo].[type] ([type_id]),
    CONSTRAINT [FK_task_user] FOREIGN KEY ([user_id]) REFERENCES [dbo].[user] ([user_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'task';

