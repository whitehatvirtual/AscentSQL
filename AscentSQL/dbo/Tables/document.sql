CREATE TABLE [dbo].[document] (
    [document_id]     INT             IDENTITY (1, 1) NOT NULL,
    [location_id]     INT             NULL,
    [folder_id]       INT             NULL,
    [key] varchar(max) null,
    [url]             NVARCHAR (MAX)  NOT NULL,
    [file_name]       NVARCHAR (255)  NOT NULL,
    [file_extension]  NVARCHAR (10)   NOT NULL,
    [file_size]       NUMERIC (18, 4) NULL,
    [is_active]       BIT             DEFAULT ((1)) NULL,
    [created_on]      DATETIME2 (7)   DEFAULT (getutcdate()) NULL,
    [updated_on]      DATETIME2 (7)   DEFAULT (getutcdate()) NULL,
    [created_by]      INT             NULL,
    [updated_by]      INT             NULL,
    [audit_client_id] INT             NULL,
    CONSTRAINT [PK_document_document_id] PRIMARY KEY CLUSTERED ([document_id] ASC),
    CONSTRAINT [FK_document_folder] FOREIGN KEY ([location_id]) REFERENCES [dbo].[location] ([location_id]),
    CONSTRAINT [FK_document_location] FOREIGN KEY ([folder_id]) REFERENCES [dbo].[location] ([location_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.document', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'document';

