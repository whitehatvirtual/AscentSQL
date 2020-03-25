CREATE TABLE [dbo].[folder] (
    [folder_id]       INT            IDENTITY (1, 1) NOT NULL,
    [location_id]     INT            NULL,
    [client_id]       INT            NULL,
    [parent_id]       INT            NULL,
    [folder_name]     NVARCHAR (255) NULL,
    [is_active]       BIT            DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7)  CONSTRAINT [DF_folder_created_on] DEFAULT (getutcdate()) NULL,
    [updated_on]      DATETIME2 (7)  DEFAULT (getutcdate()) NULL,
    [created_by]      INT            NULL,
    [updated_by]      INT            NULL,
    [audit_client_id] INT            NULL,
    CONSTRAINT [PK_folder_folder_id] PRIMARY KEY CLUSTERED ([folder_id] ASC),
    CONSTRAINT [FK_folder_client] FOREIGN KEY ([client_id]) REFERENCES [dbo].[client] ([client_id]),
    CONSTRAINT [FK_folder_folder] FOREIGN KEY ([parent_id]) REFERENCES [dbo].[folder] ([folder_id]),
    CONSTRAINT [FK_folder_location] FOREIGN KEY ([location_id]) REFERENCES [dbo].[location] ([location_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.folder', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'folder';

