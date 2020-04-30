CREATE TABLE [dbo].[incident_suspected_source] (
    [incident_suspected_source_id] INT            IDENTITY (1, 1) NOT NULL,
    [ip]                           VARCHAR (100)  NULL,
    [hostname]                     NVARCHAR (255) NULL,
    [reason]                       NVARCHAR (100) NULL,
    CONSTRAINT [PK_incident_suspected_source] PRIMARY KEY CLUSTERED ([incident_suspected_source_id] ASC)
);

