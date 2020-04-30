CREATE TABLE [dbo].[location_property] (
    [location_property_id] INT            IDENTITY (1, 1) NOT NULL,
    [location_id]          INT            NULL,
    [property_id]          INT            NULL,
    [value]                VARCHAR (4000) NULL,
    [is_active]            BIT            CONSTRAINT [DF__location___is_ac__3D2915A8] DEFAULT ((1)) NULL,
    [created_on]           DATETIME2 (7)  CONSTRAINT [DF__location___creat__3E1D39E1] DEFAULT (getutcdate()) NULL,
    [updated_on]           DATETIME2 (7)  CONSTRAINT [DF__location___updat__3F115E1A] DEFAULT (getutcdate()) NULL,
    [created_by]           INT            NULL,
    [updated_by]           INT            NULL,
    [audit_client_id]      INT            NULL,
    CONSTRAINT [PK_location_property] PRIMARY KEY CLUSTERED ([location_property_id] ASC),
    CONSTRAINT [FK_location_property_location] FOREIGN KEY ([location_id]) REFERENCES [dbo].[location] ([location_id]),
    CONSTRAINT [FK_location_property_property] FOREIGN KEY ([property_id]) REFERENCES [dbo].[property] ([property_id])
);



