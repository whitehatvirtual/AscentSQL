-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[error_rais]
	-- Add the parameters for the stored procedure here
		 @jsonVariable NVARCHAR(MAX)
		,@audit_user_id int 
		,@audit_client_id int 
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @error nvarchar(max)

	--select @error = (SELECT e.[error_id]
	--				  ,[error_no]
	--				  ,[description]
	--				FROM [error] as e 
	--				join (	SELECT error_id
	--						FROM OPENJSON (@jsonVariable, N'$')
	--							WITH (
				
	--									error_id int N'$.error_id'
					
	--							) AS folder
	--					) as ei on e.error_id = ei.error_id
	--				for JSON AUTO -- , WITHOUT_ARRAY_WRAPPER
	--				)
	select @error ='['+stuff( (SELECT ','+ CONVERT(VARCHAR(500),e.[error_id])
					  
				FROM [error] as e 
				join (	SELECT error_id
						FROM OPENJSON (@jsonVariable, N'$')
							WITH (
				
									error_id int N'$.error_id'
					
							) AS folder
					) as ei on e.error_id = ei.error_id
				for xml path('') -- , WITHOUT_ARRAY_WRAPPER
				),1,1,'')+']'
    -- Insert statements for procedure here
	;throw 51000, @error, 1;--(@error, -- Message text.  
          -- 16, -- Severity,  
         --  1 -- State,  
           
          -- ); -- Second argument.
END