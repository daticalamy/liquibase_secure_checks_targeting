--liquibase formatted sql

--changeset asmith:proc02a splitStatements:false stripComments:false
CREATE OR REPLACE PROCEDURE abc.update_employee_salary(
    emp_id INT,
    new_salary NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    old_salary NUMERIC;  -- variable to hold the previous salary
BEGIN
    -- Fetch the current salary before updating
    SELECT salary INTO old_salary
    FROM employees
    WHERE employee_id = emp_id;

    /* 
       Only update if the new salary is actually different.
       This avoids unnecessary writes and audit log noise.
    */
    IF old_salary IS DISTINCT FROM new_salary THEN
        UPDATE employees
        SET salary = new_salary
        WHERE employee_id = emp_id;

        -- Log the change for auditing purposes
        INSERT INTO salary_audit_log (employee_id, old_salary, new_salary, changed_at)
        VALUES (emp_id, old_salary, new_salary, now());
    END IF;
END;
$$;