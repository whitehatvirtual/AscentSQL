CREATE TABLE [dbo].[service_tier_parameter] (
    [service_tier_parameter_id] INT           IDENTITY (1, 1) NOT NULL,
    [service_tier_id]           INT           NULL,
    [parameter_id]              INT           NULL,
    [value]                     VARCHAR (255) NULL,
    [is_active]                 BIT           DEFAULT ((1)) NULL,
    [created_on]                DATETIME2 (7) DEFAULT (getdate()) NULL,
    [updated_on]                DATETIME2 (7) DEFAULT (getdate()) NULL,
    [created_by]                INT           NULL,
    [updated_by]                INT           NULL,
    [audit_client_id]           INT           NULL,
    CONSTRAINT [PK_service_tier_parameter_service_tier_parameter_id] PRIMARY KEY CLUSTERED ([service_tier_parameter_id] ASC)
);

