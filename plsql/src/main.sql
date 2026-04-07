-- PL/SQL SonarQube Example
-- Minimal stored procedure with basic logic

CREATE OR REPLACE PROCEDURE calculate_result (
    p_a IN NUMBER,
    p_b IN NUMBER,
    p_result OUT NUMBER,
    p_error OUT VARCHAR2
)
IS
BEGIN
    p_error := NULL;

    -- Basic addition
    p_result := p_a + p_b;

    -- Check for zero divisor (just for demo)
    IF p_b = 0 THEN
        p_error := 'Warning: Second operand is zero';
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        p_error := SQLERRM;
        p_result := NULL;
END calculate_result;
/

-- Simple function
CREATE OR REPLACE FUNCTION add_numbers (
    a NUMBER,
    b NUMBER
) RETURN NUMBER
IS
BEGIN
    RETURN a + b;
END add_numbers;
/

-- Function with error handling
CREATE OR REPLACE FUNCTION safe_divide (
    a NUMBER,
    b NUMBER
) RETURN NUMBER
IS
BEGIN
    IF b = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Division by zero');
    END IF;
    RETURN a / b;
END safe_divide;
/

-- Package specification
CREATE OR REPLACE PACKAGE calculator_pkg
IS
    FUNCTION multiply (a NUMBER, b NUMBER) RETURN NUMBER;
    FUNCTION is_valid (value NUMBER) RETURN BOOLEAN;
END calculator_pkg;
/

CREATE OR REPLACE PACKAGE BODY calculator_pkg
IS
    FUNCTION multiply (a NUMBER, b NUMBER) RETURN NUMBER
    IS
    BEGIN
        RETURN a * b;
    END multiply;

    FUNCTION is_valid (value NUMBER) RETURN BOOLEAN
    IS
    BEGIN
        RETURN value >= 0 AND value <= 100;
    END is_valid;
END calculator_pkg;
/