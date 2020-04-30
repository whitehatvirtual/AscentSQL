CREATE TABLE [dbo].[incident] (
    [incident_id]        INT            IDENTITY (1, 1) NOT NULL,
    [incident_name]      NVARCHAR (255) NULL,
    [description]        NVARCHAR (MAX) NULL,
    [incident_no]        NVARCHAR (255) NULL,
    [client_id]          INT            NULL,
    [user_id]            INT            NULL,
    [incident_date_time] DATETIME2 (7)  NULL,
    [status_id]          INT            NULL,
    [handler_name]       NVARCHAR (MAX) NULL,
    [handler_email]      NVARCHAR (MAX) NULL,
    [handler_phone]      VARCHAR (255)  NULL,
    [handler_title]      NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_incident] PRIMARY KEY CLUSTERED ([incident_id] ASC)
);

