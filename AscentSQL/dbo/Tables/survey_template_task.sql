CREATE TABLE [dbo].[survey_template_task] (
    [survey_template_task_id]    INT            IDENTITY (1, 1) NOT NULL,
    [survey_template_id]         INT            NULL,
    [survey_template_control_id] INT            NULL,
    [survey_template_task_name]  NVARCHAR (255) NULL,
    [description]                NVARCHAR (MAX) NULL,
    [Schedule]                   VARCHAR (MAX)  NULL,
    [type_id]                    INT            NULL,
    [is_active]                  BIT            DEFAULT ((1)) NULL,
    [created_on]                 DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [updated_on]                 DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]                 INT            NULL,
    [updated_by]                 INT            NULL,
    [audit_client_id]            INT            NULL,
    CONSTRAINT [PK_survey_template_task_survey_template_task_id] PRIMARY KEY CLUSTERED ([survey_template_task_id] ASC),
    CONSTRAINT [FK_survey_template_task_survey_template] FOREIGN KEY ([survey_template_id]) REFERENCES [dbo].[survey_template] ([survey_template_id]),
    CONSTRAINT [FK_survey_template_task_survey_template_control] FOREIGN KEY ([survey_template_control_id]) REFERENCES [dbo].[survey_template_control] ([survey_template_control_id]),
    CONSTRAINT [FK_survey_template_task_type] FOREIGN KEY ([type_id]) REFERENCES [dbo].[type] ([type_id])
);

