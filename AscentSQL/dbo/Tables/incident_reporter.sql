CREATE TABLE [dbo].[incident_reporter] (
    [incident_reporter_id]    INT            IDENTITY (1, 1) NOT NULL,
    [incident_id]             INT            NULL,
    [incident_reporter_name]  NVARCHAR (255) NULL,
    [incident_reporter_title] NVARCHAR (255) NULL,
    [department]              NVARCHAR (255) NULL,
    [email]                   VARCHAR (255)  NULL,
    [phone]                   VARCHAR (255)  NULL,
    [submited_to]             NVARCHAR (255) NULL,
    CONSTRAINT [PK_incident_reporter] PRIMARY KEY CLUSTERED ([incident_reporter_id] ASC)
);

