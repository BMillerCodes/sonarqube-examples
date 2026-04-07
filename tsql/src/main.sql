-- T-SQL SonarQube Example
-- Minimal stored procedure with basic logic

CREATE PROCEDURE CalculateResult
    @a INT,
    @b INT,
    @result INT OUTPUT,
    @error NVARCHAR(100) OUTPUT
AS
BEGIN
    SET @error = NULL;

    -- Basic addition
    SET @result = @a + @b;

    -- Check for zero divisor
    IF @b = 0
    BEGIN
        SET @error = N'Warning: Second operand is zero';
    END

    -- Try/catch for error handling
    BEGIN TRY
        IF @b = 0
            THROW 50001, N'Division by zero', 1;
    END TRY
    BEGIN CATCH
        SET @error = ERROR_MESSAGE();
    END CATCH
END
GO

-- Scalar function
CREATE FUNCTION AddNumbers
(
    @a INT,
    @b INT
)
RETURNS INT
AS
BEGIN
    RETURN @a + @b;
END
GO

-- Function with error handling
CREATE FUNCTION SafeDivide
(
    @a INT,
    @b INT
)
RETURNS INT
AS
BEGIN
    IF @b = 0
        THROW 50001, N'Division by zero', 1;
    RETURN @a / @b;
END
GO

-- Multi-statement table-valued function
CREATE FUNCTION GetNumbers()
RETURNS @result TABLE
(
    ID INT,
    Value NVARCHAR(50)
)
AS
BEGIN
    INSERT INTO @result (ID, Value)
    VALUES (1, N'One'), (2, N'Two'), (3, N'Three');
    RETURN;
END
GO
