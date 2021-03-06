﻿CREATE TABLE [dbo].[survey_template_control] (
    [survey_template_control_id] INT           IDENTITY (1, 1) NOT NULL,
    [survey_template_id]         INT           NULL,
    [control_id]                 INT           NULL,
    [is_active]                  BIT           DEFAULT ((1)) NULL,
    [created_on]                 DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [updated_on]                 DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [created_by]                 INT           NULL,
    [updated_by]                 INT           NULL,
    [audit_client_id]            INT           NULL,
    CONSTRAINT [PK_survey_template_control_survey_template_control_id] PRIMARY KEY CLUSTERED ([survey_template_control_id] ASC),
    CONSTRAINT [FK_survey_template_control_control] FOREIGN KEY ([control_id]) REFERENCES [dbo].[control] ([control_id]),
    CONSTRAINT [FK_survey_template_control_survey_template] FOREIGN KEY ([survey_template_id]) REFERENCES [dbo].[survey_template] ([survey_template_id])
);

