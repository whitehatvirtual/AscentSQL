CREATE TABLE [dbo].[incident_network] (
    [incident_network_id] INT             NOT NULL,
    [incident_id]         INT             NULL,
    [ip]                  VARCHAR (100)   NULL,
    [hostname]            VARCHAR (255)   NULL,
    [os]                  NVARCHAR (1000) NULL,
    [application]         NVARCHAR (1000) NULL
);

