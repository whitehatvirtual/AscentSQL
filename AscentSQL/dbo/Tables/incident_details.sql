CREATE TABLE [dbo].[incident_details] (
    [incident_details_id]   INT             IDENTITY (1, 1) NOT NULL,
    [incident_id]           INT             NULL,
    [discovery_time]        DATETIME2 (7)   NULL,
    [estimated_start_time]  DATETIME2 (7)   NULL,
    [discovery_how]         NVARCHAR (255)  NULL,
    [description]           NVARCHAR (1000) NULL,
    [phi_pii]               NVARCHAR (255)  NULL,
    [incident_location]     NVARCHAR (255)  NULL,
    [current_state]         NVARCHAR (255)  NULL,
    [incident_source]       NVARCHAR (255)  NULL,
    [witness]               NVARCHAR (1000) NULL,
    [os]                    NVARCHAR (1000) NULL,
    [antivirus]             NVARCHAR (1000) NULL,
    [afected_resources]     NVARCHAR (1000) NULL,
    [mitigating_factors]    NVARCHAR (1000) NULL,
    [incident_impact]       NVARCHAR (255)  NULL,
    [incident_response]     NVARCHAR (255)  NULL,
    [organization_contacts] NVARCHAR (1000) NULL,
    [augumented_by]         NVARCHAR (1000) NULL,
    [comment]               NVARCHAR (1000) NULL,
    CONSTRAINT [PK_incident_details] PRIMARY KEY CLUSTERED ([incident_details_id] ASC)
);

