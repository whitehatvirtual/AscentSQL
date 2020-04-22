CREATE TABLE [dbo].[survey] (
    [survey_id]          INT            IDENTITY (1, 1) NOT NULL,
    [survey_template_id] INT            NULL,
    [client_id]            INT null,
    [survey_name]        NVARCHAR (255) NULL,
    [description]        NVARCHAR (MAX) NULL,
    [type_id]            INT            NULL,
    [is_complete]        BIT            NULL,
    [is_active]          BIT            DEFAULT ((1)) NULL,
    [created_on]         DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [updated_on]         DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]         INT            NULL,
    [updated_by]         INT            NULL,
    [audit_client_id]    INT            NULL,
    CONSTRAINT [PK_survey_survey_id] PRIMARY KEY CLUSTERED ([survey_id] ASC),
    CONSTRAINT [FK_survey_survey_template] FOREIGN KEY ([survey_template_id]) REFERENCES [dbo].[survey_template] ([survey_template_id]),
    CONSTRAINT [FK_survey_type] FOREIGN KEY ([type_id]) REFERENCES [dbo].[type] ([type_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.survey', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'survey';

