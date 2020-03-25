CREATE TABLE [dbo].[frequency] (
    [frequency_id]   INT           IDENTITY (1, 1) NOT NULL,
    [frequency_name] VARCHAR (255) NULL,
    [months_count]   INT           NULL,
    [is_active]      BIT           DEFAULT ((1)) NULL,
    CONSTRAINT [PK_frequency_frequency_id] PRIMARY KEY CLUSTERED ([frequency_id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.frequency', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'frequency';

