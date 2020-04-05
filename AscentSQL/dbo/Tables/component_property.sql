CREATE TABLE [dbo].[component_property] (
    [component_property_id] INT           IDENTITY (1, 1) NOT NULL,
    [component_id]          INT           NULL,
    [property_id]           INT           NULL,
    [value]                 VARCHAR (255) NULL,
    [is_active]             BIT           DEFAULT ((1)) NULL,
    [created_on]            DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [updated_on]            DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [created_by]            INT           NULL,
    [updated_by]            INT           NULL,
    [audit_client_id]       INT           NULL,
    CONSTRAINT [PK_component_property] PRIMARY KEY CLUSTERED ([component_property_id] ASC)
);

