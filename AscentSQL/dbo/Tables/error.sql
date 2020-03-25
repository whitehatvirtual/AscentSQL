CREATE TABLE [dbo].[error] (
    [error_id]    INT             IDENTITY (1, 1) NOT NULL,
    [error_no]    NVARCHAR (255)  NULL,
    [description] NVARCHAR (4000) NULL,
    [locale]      NVARCHAR (6)    CONSTRAINT [DF_error_locale] DEFAULT (N'en-US') NULL,
    CONSTRAINT [PK_error] PRIMARY KEY CLUSTERED ([error_id] ASC)
);

