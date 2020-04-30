CREATE TABLE [dbo].[parameter] (
    [parameter_id]   INT           IDENTITY (1, 1) NOT NULL,
    [parameter_name] VARCHAR (255) NULL,
    [description]    VARCHAR (MAX) NULL,
    [value]          VARCHAR (255) NULL,
    CONSTRAINT [PK_parameter] PRIMARY KEY CLUSTERED ([parameter_id] ASC)
);

