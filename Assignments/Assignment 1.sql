-- 1. SET PRIMARY KEY
CREATE or replace table AN_Sales
(   order_id VARCHAR(20),
    order_date date, 
    ship_date date, 
    ship_mode CHAR(15), 
    customer_name CHAR(40),
    segment CHAR(11),
    state CHAR(80),
    country CHAR(80),
    market CHAR(8),
    region CHAR(20),
    product_id VARCHAR(30),
    category CHAR(15),
    sub_category CHAR(20),
    product_name VARCHAR(150),
    sales NUMBER(8),
    quantity NUMBER(2),
    discount float,
    profit float,
    shipping_cost float,
    order_priority CHAR(8),
    Year CHAR(4)
);

ALTER TABLE AN_SALES
ADD COLUMN order_product_id VARCHAR(60);

ALTER TABLE AN_SALES
ADD PRIMARY KEY (order_product_id);

UPDATE AN_SALES
SET order_product_id = CONCAT(order_id,'-',product_id);

DESCRIBE TABLE AN_SALES;

-- 2. CHECK THE ORDER DATE AND SHIP DATE TYPE AND THINK IN WHICH DATA TYPE YOU HAVE TO CHANGE.
-- Done in excel

-- 3. EXTACT THE LAST NUMBER AFTER THE - AND CREATE OTHER COLUMN AND UPDATE IT.
SELECT SPLIT(order_id,'-') AS Country_Year_ID FROM AN_SALES;

-- 4.  FLAG ,IF DISCOUNT IS GREATER THEN 0 THEN  YES ELSE FALSE AND PUT IT IN NEW COLUMN FRO EVERY ORDER ID.
SELECT *,
 CASE
    WHEN DISCOUNT > 0 THEN 'YES'
    ELSE 'NO'
    END Discount_Available
FROM AN_Sales;    

-- 5.  FIND OUT THE FINAL PROFIT AND PUT IT IN COLUMN FOR EVERY ORDER ID.
SELECT *, quantity * profit AS Final_profit FROM AN_SALES;

-- 6.  FIND OUT HOW MUCH DAYS TAKEN FOR EACH ORDER TO PROCESS FOR THE SHIPMENT FOR EVERY ORDER ID.
-- 7 . FLAG THE PROCESS DAY AS BY RATING IF IT TAKES LESS OR EQUAL 3  DAYS MAKE 5,LESS OR EQUAL THAN 6 DAYS BUT MORE THAN 3 MAKE 4,LESS THAN 10 BUT MORE THAN 6 MAKE 3,MORE THAN 10 MAKE IT 2 FOR EVERY ORDER ID.

SELECT *, DATEDIFF(day,order_date,ship_date) AS process_days,
CASE
    WHEN process_days <= 3 THEN 5
    WHEN process_days > 3 AND process_days <=6 THEN 4
    WHEN process_days > 6 AND process_days <=10 THEN 3
    ELSE 2
    END Rating
FROM AN_Sales;