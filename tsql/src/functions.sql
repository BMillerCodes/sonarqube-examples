-- T-SQL helper functions

-- String formatting
CREATE FUNCTION FormatMessage
(
    @message NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    RETURN N'[INFO] ' + @message;
END
GO

-- Validation
CREATE FUNCTION IsPositive
(
    @value INT
)
RETURNS BIT
AS
BEGIN
    RETURN CASE WHEN @value > 0 THEN 1 ELSE 0 END;
END
GO

-- Recursive factorial
CREATE FUNCTION Factorial
(
    @n INT
)
RETURNS BIGINT
AS
BEGIN
    IF @n <= 1
        RETURN 1;
    RETURN @n * dbo.Factorial(@n - 1);
END
GO
