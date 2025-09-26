----------------exp 6
--medium
CREATE TABLE Employeess (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(50),
    gender VARCHAR(10)
);
INSERT INTO Employeess (emp_name, gender) VALUES
('Alice', 'Female'),
('Bob', 'Male'),
('Charlie', 'Male'),
('Diana', 'Female');
drop procedure if exists get_employee_count_by_gender
CREATE OR REPLACE PROCEDURE get_employee_count_by_gender(
    IN input_gender VARCHAR,
    OUT total_count INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*) 
    INTO total_count
    FROM Employeess
    WHERE gender = input_gender;

    RAISE NOTICE 'Gender: %, Total Employees: %', input_gender, total_count;
END;
$$;
CALL get_employee_count_by_gender('Male', total_count => 0);
CALL get_employee_count_by_gender('Female', total_count => 0);


---hard
-- Products Table
-- Items Table
CREATE TABLE Items (
    item_id SERIAL PRIMARY KEY,
    item_name VARCHAR(50),
    price DECIMAL(10,2),
    quantity_remaining INT,
    quantity_sold INT DEFAULT 0
);

-- Orders Table
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    item_id INT REFERENCES Items(item_id),
    quantity_ordered INT,
    total_price DECIMAL(10,2),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE OR REPLACE PROCEDURE process_order(
    IN input_item_id INT,
    IN input_quantity INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    available_stock INT;
    item_price DECIMAL(10,2);
    total_cost DECIMAL(10,2);
BEGIN
    -- Check available stock and price
    SELECT quantity_remaining, price
    INTO available_stock, item_price
    FROM Items
    WHERE item_id = input_item_id;

    -- If enough stock available
    IF available_stock >= input_quantity THEN
        total_cost := item_price * input_quantity;

        -- Insert order into Orders table
        INSERT INTO Orders (item_id, quantity_ordered, total_price)
        VALUES (input_item_id, input_quantity, total_cost);

        -- Update inventory in Items table
        UPDATE Items
        SET quantity_remaining = quantity_remaining - input_quantity,
            quantity_sold = quantity_sold + input_quantity
        WHERE item_id = input_item_id;

        RAISE NOTICE 'Product sold successfully!';
    ELSE
        RAISE NOTICE 'Insufficient Quantity Available!';
    END IF;
END;
$$;
CALL process_order(1, 2);

