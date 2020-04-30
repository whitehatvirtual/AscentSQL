CREATE TABLE [dbo].[task_color] (
    [task_color_id]   INT          IDENTITY (1, 1) NOT NULL,
    [type_id]         INT          NULL,
    [status_id]       INT          NULL,
    [textColor]       VARCHAR (30) NULL,
    [backgroundColor] VARCHAR (30) NULL,
    CONSTRAINT [PK_task_color] PRIMARY KEY CLUSTERED ([task_color_id] ASC)
);

