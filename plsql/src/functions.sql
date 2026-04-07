-- PL/SQL helper functions

-- String formatting function
CREATE OR REPLACE FUNCTION format_message (
    p_message VARCHAR2
) RETURN VARCHAR2
IS
BEGIN
    RETURN '[INFO] ' || p_message;
END format_message;
/

-- Validation function
CREATE OR REPLACE FUNCTION is_positive (
    p_value NUMBER
) RETURN BOOLEAN
IS
BEGIN
    RETURN p_value > 0;
END is_positive;
/

-- Recursive factorial
CREATE OR REPLACE FUNCTION factorial (
    n NUMBER
) RETURN NUMBER
IS
BEGIN
    IF n <= 1 THEN
        RETURN 1;
    END IF;
    RETURN n * factorial(n - 1);
END factorial;
/