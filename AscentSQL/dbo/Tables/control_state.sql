CREATE TABLE [dbo].[control_state]
(
	[control_state_id] INT identity (1,1 )NOT NULL PRIMARY KEY, 
    [control_state_name] VARCHAR(255) NULL, 
    [is_active] BIT NULL DEFAULT 1
)
