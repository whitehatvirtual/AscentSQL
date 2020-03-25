CREATE TABLE [dbo].[icon] (
    [icon_id]      INT           IDENTITY (1, 1) NOT NULL,
    [icon_name]    VARCHAR (100) NULL,
    [ui_icon_name] VARCHAR (100) NULL,
    CONSTRAINT [PK_icon] PRIMARY KEY CLUSTERED ([icon_id] ASC)
);

