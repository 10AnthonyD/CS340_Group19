/*
 * Customers
 */
-- Get all customers
SELECT * FROM Customers;

-- Add a new customer
INSERT INTO Customers(first_name, last_name, email, phone)
VALUES (@first_name, @last_name, @email, @phone);

-- Update a customer
UPDATE Customers
SET first_name = @first_name, last_name = @last_name, email = @email, phone = @phone
WHERE customer_id = @customer_id;

DELETE FROM Customers WHERE customer_id = @customer_id;

-- Get a customer_id by email (for creating orders)
SELECT customer_id FROM Customers WHERE email = @email;

-- Get a customer_id by phone (for creating orders)
SELECT customer_id FROM Customers WHERE phone = @phone;

/*
 * CardsPrimaryType
 */
SELECT * FROM CardsPrimaryType;

SELECT identity_id FROM CardsPrimaryType;

/*
 * Cards
 */
 -- Get all cards
SELECT * FROM Cards;

-- Add new card
INSERT INTO Cards(card_name, is_uncolored, is_red, is_green, is_white, is_black, is_blue, card_action, primary_type)
VALUES (@card_name, @is_uncolored, @is_red, @is_green, @is_white, @is_black, @is_blue, @card_action, @primary_type);

-- Update a card
UPDATE Cards
SET card_name = @card_name, is_uncolored = @is_uncolored, is_red = @is_red, is_green = @is_green, is_white = @is_white,
	is_black = @is_black, is_blue = @is_blue, card_action = @card_action, primary_type = @primary_type
WHERE card_id = @card_id;

-- Delete a card
DELETE FROM Cards WHERE card_id = @card_id;

-- Find card by name
SELECT card_id FROM Cards WHERE card_name = @card_name;

-- Display Card name and primary type
SELECT card_name, primary_type FROM Cards;

/*
 * Orders
 */
SELECT * FROM Orders;

-- Create a new order
INSERT INTO Orders(customer_id, credit_card)
VALUES (@customer_id, @credit_card);

-- Update an order
UPDATE Orders
SET customer_id = @customer_id, credit_card = @credit_card
WHERE order_id = @order_id;

-- Delete an order
DELETE FROM Orders WHERE order_id = @order_id;

-- Get an order by customer id
SELECT order_id FROM Orders WHERE customer_id = @customer_id;

/*
 * CardsPerOrder
 */
SELECT * FROM CardsPerOrder;

-- Add items to CardsPerOrder
INSERT INTO CardsPerOrder(order_id, card_id, quantity)
VALUES (@order_id, @card_id, @quantity);

-- Update CardsPerOrder
UPDATE CardsPerOrder
SET order_id = @order_id, card_id = @card_id, quantity = @quantity
WHERE order_details_id = @order_details_id;

DELETE FROM CardsPerOrder WHERE order_details_id = @order_details_id;