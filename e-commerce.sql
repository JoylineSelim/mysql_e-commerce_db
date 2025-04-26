-- create the database
CREATE DATABASE IF NOT EXISTS ECOMMERCE;

-- select the database
USE ECOMMERCE;

-- create the various tables
-- 1. Brand Table
CREATE TABLE brand (
    id INT AUTO_INCREMENT PRIMARY KEY,
    brandname VARCHAR(100) NOT NULL
);

-- 2. Product Category Table
CREATE TABLE product_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoryname VARCHAR(100) NOT NULL
);

-- 3. Product Table
CREATE TABLE product (
    productid INT AUTO_INCREMENT PRIMARY KEY,
    productname VARCHAR(150) NOT NULL,
    base_price DECIMAL(10, 2) NOT NULL,
    brand_id INT,
    category_id INT,
    FOREIGN KEY (brand_id) REFERENCES brand(id),
    FOREIGN KEY (category_id) REFERENCES product_category(id)
);

-- 4. Color Table
CREATE TABLE color (
    id INT AUTO_INCREMENT PRIMARY KEY,
    colorname VARCHAR(50) NOT NULL,
    hex_code VARCHAR(7) -- Example: #FFFFFF
);

-- 5. Size Category Table
CREATE TABLE size_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 6. Size Option Table
CREATE TABLE size_option (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    size_category_id INT,
    FOREIGN KEY (size_category_id) REFERENCES size_category(id)
);

-- 7. Product Variation Table
CREATE TABLE product_variation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    color_id INT,
    size_option_id INT,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (color_id) REFERENCES color(id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(id)
);

-- 8. Product Item Table
CREATE TABLE product_item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_variation_id INT,
    sku VARCHAR(100) UNIQUE,
    stock_quantity INT DEFAULT 0,
    price DECIMAL(10,2), -- price may differ slightly based on variation
    FOREIGN KEY (product_variation_id) REFERENCES product_variation(id)
);

-- 9. Product Image Table
CREATE TABLE product_image (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    image_url VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

-- 10. Attribute Category Table
CREATE TABLE attribute_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 11. Attribute Type Table
CREATE TABLE attribute_type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    attribute_category_id INT,
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(id)
);

-- 12. Product Attribute Table
CREATE TABLE product_attribute (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    attribute_type_id INT,
    value VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(id)
);

-- Insert values
-- Insert into brand
INSERT INTO brand (brandname) VALUES 
('Nike'), 
('Apple'), 
('Samsung');

-- Insert into product_category
INSERT INTO product_category (categoryname) VALUES 
('Clothing'), 
('Electronics'), 
('Accessories');

-- Insert into product
INSERT INTO product (productname, base_price, brand_id, category_id) VALUES 
('Air Max 90', 120.00, 1, 1),
('iPhone 15', 999.00, 2, 2),
('Galaxy Buds 2', 150.00, 3, 3);

-- Insert into color
INSERT INTO color (colorname, hex_code) VALUES 
('Red', '#FF0000'),
('Black', '#000000'),
('White', '#FFFFFF');

-- Insert into size_category
INSERT INTO size_category (name) VALUES 
('Clothing Size'), 
('Shoe Size'), 
('Electronics Size');

-- Insert into size_option
INSERT INTO size_option (name, size_category_id) VALUES 
('M', 1),
('42', 2),
('One Size', 3);

-- Insert into product_variation
INSERT INTO product_variation (product_id, color_id, size_option_id) VALUES 
(1, 2, 2), -- Air Max 90, Black, Size 42
(2, 3, 3), -- iPhone 15, White, One Size
(3, 1, 3); -- Galaxy Buds 2, Red, One Size

-- Insert into product_item
INSERT INTO product_item (product_variation_id, sku, stock_quantity, price) VALUES 
(1, 'NIKE-AM90-BLK-42', 10, 120.00),
(2, 'APPLE-IP15-WHT-OS', 5, 999.00),
(3, 'SAM-BUDS2-RED-OS', 15, 150.00);

-- Insert into product_image
INSERT INTO product_image (product_id, image_url) VALUES 
(1, 'https://example.com/airmax90.jpg'),
(2, 'https://example.com/iphone15.jpg'),
(3, 'https://example.com/galaxybuds2.jpg');

-- Insert into attribute_category
INSERT INTO attribute_category (name) VALUES 
('Physical Attributes'), 
('Technical Specs'), 
('Other Features');

-- Insert into attribute_type
INSERT INTO attribute_type (name, attribute_category_id) VALUES 
('Material', 1),
('Battery Life', 2),
('Water Resistant', 3);

-- Insert into product_attribute
INSERT INTO product_attribute (product_id, attribute_type_id, value) VALUES 
(1, 1, 'Leather'),            -- Air Max 90 - Material: Leather
(2, 2, '20 Hours'),           -- iPhone 15 - Battery Life: 20 Hours
(3, 3, 'Yes');                -- Galaxy Buds 2 - Water Resistant: Yes
