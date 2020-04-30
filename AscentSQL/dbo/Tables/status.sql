CREATE TABLE [dbo].[status] (
    [ststus_id]   INT            IDENTITY (1, 1) NOT NULL,
    [status_name] NVARCHAR (100) NULL,
    CONSTRAINT [PK_status] PRIMARY KEY CLUSTERED ([ststus_id] ASC)
);

