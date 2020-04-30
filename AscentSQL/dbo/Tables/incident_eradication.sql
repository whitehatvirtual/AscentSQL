CREATE TABLE [dbo].[incident_eradication] (
    [incident_eradicationt_id] INT             IDENTITY (1, 1) NOT NULL,
    [incident_id]              INT             NULL,
    [activity_id]              INT             NULL,
    [information]              NVARCHAR (1000) NULL,
    [completed_by]             NVARCHAR (1000) NULL,
    [date_completed]           DATETIME2 (7)   NULL,
    [not_applicable]           BIT             NULL,
    CONSTRAINT [PK_incident_eradication] PRIMARY KEY CLUSTERED ([incident_eradicationt_id] ASC)
);

