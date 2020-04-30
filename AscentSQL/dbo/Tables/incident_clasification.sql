CREATE TABLE [dbo].[incident_clasification] (
    [incident_clasification_id]   INT IDENTITY (1, 1) NOT NULL,
    [incident_id]                 INT NULL,
    [dos]                         BIT NULL,
    [loss_of_equipment]           BIT NULL,
    [physical_security_violation] BIT NULL,
    [virus]                       BIT NULL,
    [web_site_defacement]         BIT NULL,
    [social_engineering]          BIT NULL,
    [bfa]                         BIT NULL,
    [user_account_compromise]     BIT NULL,
    [hoax]                        BIT NULL,
    [system_misuse]               BIT NULL,
    [other_intrusion]             BIT NULL,
    [network_scanning]            BIT NULL,
    [technical_vulnerability]     BIT NULL,
    [root_compromise]             BIT NULL,
    [other]                       BIT NULL,
    [other_comment]               BIT NULL,
    CONSTRAINT [PK_incident_clasification] PRIMARY KEY CLUSTERED ([incident_clasification_id] ASC)
);

