CREATE TABLE [dbo].[activity] (
    [activity_id]   INT            IDENTITY (1, 1) NOT NULL,
    [activity_name] NVARCHAR (255) NULL,
    [type_id]       INT            NULL,
    CONSTRAINT [PK_activity] PRIMARY KEY CLUSTERED ([activity_id] ASC)
);

