CREATE TABLE [dbo].[user_access] (
    [user_access_id]  INT           IDENTITY (1, 1) NOT NULL,
    [user_client_id]  INT           NULL,
    [location_id]     INT           NULL,
    [type_id]         INT           NULL,
    [is_active]       BIT           DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7) NULL,
    [updated_on]      DATETIME2 (7) DEFAULT (getutcdate()) NULL,
    [created_by]      INT           NULL,
    [updated_by]      INT           NULL,
    [audit_client_id] INT           NULL,
    CONSTRAINT [PK_user_access_user_access_id] PRIMARY KEY CLUSTERED ([user_access_id] ASC),
    CONSTRAINT [FK_user_access_location] FOREIGN KEY ([location_id]) REFERENCES [dbo].[location] ([location_id]),
    CONSTRAINT [FK_user_access_type] FOREIGN KEY ([type_id]) REFERENCES [dbo].[type] ([type_id]),
    CONSTRAINT [FK_user_access_user_client] FOREIGN KEY ([user_client_id]) REFERENCES [dbo].[user_client] ([user_client_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.user_access', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'user_access';

