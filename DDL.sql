-- Group 19 Anthony Dotter and Pavel Belyaev

SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;

-- Creating tables
-- Holds information about a customer, such as their name, email and phone number.
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
	customer_id int(11) NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	phone VARCHAR(15),
	PRIMARY KEY (customer_id),
	UNIQUE(email)
);

-- A category table storing information about all card primary types.
DROP TABLE IF EXISTS CardPrimaryTypes;
CREATE TABLE CardPrimaryTypes (
	identity_id VARCHAR(20) NOT NULL,
	description VARCHAR(255),
	PRIMARY KEY (identity_id)
);

-- An individual trading card. Which will have a color identity, a card type referenced
-- through foreign key, a description of the card’s action and be uniquely identified.
DROP TABLE IF EXISTS Cards;
CREATE TABLE Cards (
	card_id int(11) NOT NULL AUTO_INCREMENT,
	card_name VARCHAR(255) NOT NULL,
	is_uncolored BINARY(1) NOT NULL,
	is_red BINARY(1) NOT NULL,
	is_green BINARY(1) NOT NULL,
	is_white BINARY(1) NOT NULL,
	is_black BINARY(1) NOT NULL,
	is_blue BINARY(1) NOT NULL,
	price DECIMAL(10,2) NOT NULL,
	card_action VARCHAR(255),
	primary_type VARCHAR(20),
	PRIMARY KEY (card_id),
	FOREIGN KEY (primary_type) REFERENCES CardPrimaryTypes(identity_id)
	ON DELETE NO ACTION;
);

-- An order of cards.
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
	order_id int(11) NOT NULL AUTO_INCREMENT,
	customer_id int(11) NOT NULL,
	credit_card VARCHAR(16),
	PRIMARY KEY (order_id),
	FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
	ON DELETE CASCADE;
);

-- An intersection table to facilitate the M : N relationship between Cards and Orders.
DROP TABLE IF EXISTS CardsPerOrder;
CREATE TABLE CardsPerOrder (
	order_details_id int(11) NOT NULL AUTO_INCREMENT,
	order_id int(11) NOT NULL,
	card_id int(11) NOT NULL,
	quantity int(11) NOT NULL,
	PRIMARY KEY (order_details_id),
	FOREIGN KEY (order_id) REFERENCES Orders(order_id)
	ON DELETE CASCADE,
	FOREIGN KEY (card_id) REFERENCES Cards(card_id)
	ON DELETE CASCADE;
);

-- Inserting sample data
-- Insert Customers
INSERT INTO Customers (first_name, last_name, email, phone)
VALUES ("John", "Douglas", "john@example.com", "123-456-7890"),
("Bill", "Richard", "bill.r@mail.com", "120-345-6789"),
("Carl", "Darnell", "carl.darnell@example.com", "123-045-8962"),
("Alex", "Richard", "alex.r@example.com", "120-783-5413");

-- Inserting card types
INSERT INTO CardPrimaryTypes (identity_id, description)
VALUES ("Artifact", "Can be played only during player's main phase. Provide state effect to gameplay."),
("Creature", "Can be played only during player's main phase. Creatures can perform combat, and if legendary can be used as commanders."),
("Enchantment", "Can be played only during player's main phase. Provide state effect to gameplay."),
("Instant", "Can be played in respponse to any game action."),
("Land", "Can be played only at player's main phase. Used to tap for mana as a resource to pay for spells."),
("Sorcery", "Can be played only at player's main phase.");

-- Inserting Cards
INSERT INTO Cards (card_name, is_uncolored, is_red, is_green, is_white, is_black, is_blue, price, card_action, primary_type)
VALUES ("Sol Ring", 1, 0, 0, 0, 0, 0, 1.35, "Tap and create 2 uncolored mana.", (SELECT identity_id FROM CardPrimaryTypes WHERE identity_id="Artifact")),
("Path to Exile", 0, 0, 0, 1, 0, 0, 0.9,
	"Exile target creature. Its controller may search his or her library for a basic land card, put thet card onto the battlefield tapped, then shuffle his or her library.",
	(SELECT identity_id FROM CardPrimaryTypes WHERE identity_id="Instant")),
("Snap", 0, 0, 0, 0, 0, 1, 1.5, "Return target creature to its owner's hand. Untap up to two lands.", (SELECT identity_id FROM CardPrimaryTypes WHERE identity_id="Instant")),
("Underworld Breach", 0, 1, 0, 0, 0, 0, 11.32,
	"Each nonland card in your graveyard has excape. The escape cost is equial to the card's mana cost plus exile three other cards from your graveyard.",
	(SELECT identity_id FROM CardPrimaryTypes WHERE identity_id="Enchantment")),
("Samut, Vizier of Naktamun", 0, 1, 1, 0, 0, 0, 7.11,
	"First strike, vigilance, haste.  Whenever a creature you control deals combat damage to a player, if that creature entered the battlefield this turn, draw a card.",
	(Select identity_id FROM CardPrimaryTypes WHERE identity_id="Creature"));
	
-- Inserting Orders
INSERT INTO Orders (customer_id, credit_card)
VALUES ((SELECT customer_id FROM Customers WHERE email="carl.darnell@example.com"), "2222542243154853"),
((SELECT customer_id FROM Customers WHERE email="alex.r@example.com"), "4224238628788330"),
((SELECT customer_id FROM Customers WHERE email="john@example.com"), "2442249036745315"),
((SELECT customer_id FROM Customers WHERE email="bill.r@mail.com"), "5342245556579145");

INSERT INTO CardsPerOrder (order_id, card_id, quantity)
VALUES (1, 1, 2),
(1, 3, 1),
(2, 4, 3),
(3, 2, 1),
(4, 3, 2);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
