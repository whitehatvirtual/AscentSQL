CREATE TABLE [dbo].[maturity] (
    [maturity_id]   INT            IDENTITY (1, 1) NOT NULL,
    [maturity_name] NVARCHAR (255) NOT NULL,
    [weight]        INT            NOT NULL,
    [is_active]     BIT            DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_maturity_maturity_id] PRIMARY KEY CLUSTERED ([maturity_id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_SSMA_SOURCE', @value = N'ascent.maturity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'maturity';

