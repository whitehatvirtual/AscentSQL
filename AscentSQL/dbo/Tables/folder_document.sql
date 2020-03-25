CREATE TABLE [dbo].[folder_document] (
    [folder_document_id] INT IDENTITY (1, 1) NOT NULL,
    [folder_id]          INT NULL,
    [document_id]        INT NULL,
    CONSTRAINT [PK_folder_document_folder_document_id] PRIMARY KEY CLUSTERED ([folder_document_id] ASC),
    CONSTRAINT [FK_folder_document_document] FOREIGN KEY ([document_id]) REFERENCES [dbo].[document] ([document_id]),
    CONSTRAINT [FK_folder_document_folder] FOREIGN KEY ([folder_id]) REFERENCES [dbo].[folder] ([folder_id])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.folder_document', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'folder_document';

