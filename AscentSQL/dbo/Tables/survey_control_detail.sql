
CREATE TABLE [dbo].[survey_control_detail] (
    [survey_control_detail_id] INT            IDENTITY (1, 1) NOT NULL,
    [survey_control_id]        INT            NULL,
    [detail_id]                INT            NULL,
    [value]                    NVARCHAR (MAX) NULL,
    [calendar_date]            DATE           NULL,
    [is_active]                BIT            NULL,
    [created_on]               DATETIME2 (7)  NULL,
    [updated_on]               DATETIME2 (7)  NULL,
    [created_by]               INT            NULL,
    [updated_by]               INT            NULL,
    [audit_client_id]          INT            NULL,
    CONSTRAINT [PK_survey_control_detail_survey_control_detail_id] PRIMARY KEY CLUSTERED ([survey_control_detail_id] ASC)
);


GO
