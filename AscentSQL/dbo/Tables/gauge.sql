CREATE TABLE [dbo].[gauge] (
    [gauge_id] INT          IDENTITY (1, 1) NOT NULL,
    [minValue] VARCHAR (30) NULL,
    [maxValue] VARCHAR (30) NULL,
    [code]     VARCHAR (30) NULL,
    CONSTRAINT [PK_gauge] PRIMARY KEY CLUSTERED ([gauge_id] ASC)
);

