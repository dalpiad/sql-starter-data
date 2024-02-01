CREATE TABLE writing_supply (
   supply_id INTEGER PRIMARY KEY AUTO_INCREMENT,
   utensil_type ENUM ("Pencil", "Pen"),
   num_drawers INTEGER
);

CREATE TABLE pencil_drawer (
   drawer_id INTEGER PRIMARY KEY AUTO_INCREMENT,
   pencil_type ENUM ("Wood", "Mechanical"),
   quantity INTEGER,
   refill BOOLEAN,
   supply_id INTEGER,
   FOREIGN KEY (supply_id) REFERENCES writing_supply(supply_id)
);

CREATE TABLE pen_drawer (
   drawer_id INTEGER PRIMARY KEY AUTO_INCREMENT,
   color ENUM ("Black", "Blue", "Red", "Green", "Purple"),
   quantity INTEGER,
   refill BOOLEAN,
   supply_id INTEGER,
   FOREIGN KEY (supply_id) REFERENCES writing_supply(supply_id)
);

SELECT *
FROM writing_supply
INNER JOIN pencil_drawer ON writing_supply.supply_id = pencil_drawer.supply_id;

SELECT writing_supply.supply_id, pencil_type, drawer_id, quantity
FROM writing_supply
INNER JOIN pencil_drawer ON writing_supply.supply_id = pencil_drawer.supply_id
WHERE refill = true AND pencil_type = "Mechanical";

SELECT writing_supply.supply_id, utensil_type, drawer_id, color
FROM writing_supply
LEFT JOIN pen_drawer ON writing_supply.supply_id = pen_drawer.supply_id;

SELECT writing_supply.supply_id, utensil_type, drawer_id, color, quantity
FROM writing_supply
LEFT JOIN pen_drawer ON writing_supply.supply_id = pen_drawer.supply_id
WHERE refill = true;

SELECT writing_supply.supply_id, utensil_type, drawer_id, quantity FROM writing_supply
LEFT JOIN pencil_drawer ON writing_supply.supply_id = pencil_drawer.supply_id
WHERE refill = true

UNION

SELECT writing_supply.supply_id, utensil_type, drawer_id, quantity FROM writing_supply
RIGHT JOIN pen_drawer ON writing_supply.supply_id = pen_drawer.supply_id
WHERE refill = true
ORDER BY supply_id;

SELECT supply_id FROM writing_supply
WHERE utensil_type = "Pen";

SELECT drawer_id, color FROM pen_drawer
WHERE quantity >= 60 AND supply_id = 5;

SELECT drawer_id, color FROM pen_drawer
WHERE supply_id IN (SELECT supply_id FROM writing_supply WHERE utensil_type = "Pen");

SELECT drawer_id, color FROM pen_drawer
WHERE supply_id IN (SELECT supply_id FROM writing_supply WHERE utensil_type = "Pen")
AND quantity >= 60;

SELECT supply_id, drawer_id, color FROM pen_drawer
WHERE supply_id = (SELECT MAX(supply_id) FROM writing_supply WHERE utensil_type = "Pen")
AND quantity >= 60;



