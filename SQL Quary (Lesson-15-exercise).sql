CREATE TABLE plant (
	plant_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    plant_name VARCHAR(120),
    zone INTEGER,
    season ENUM("Winter", "Spring", "Summer", "Fall")
);
    
CREATE TABLE seeds (
	seed_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    expiration_date DATE,
    quantity INTEGER,
    reorder BOOL,
	plant_id INTEGER,
	FOREIGN KEY (plant_id) REFERENCES plant(plant_id)
);
    
CREATE TABLE garden_bed (
	space_number INTEGER PRIMARY KEY AUTO_INCREMENT,
    date_planted DATE,
    doinggarden_bed_well BOOL,
	plant_id INTEGER,
	FOREIGN KEY (plant_id) REFERENCES plant(plant_id)
);

SELECT *
FROM seeds
INNER JOIN garden_bed ON (seeds.plant_id=garden_bed.plant_id);

SELECT *
FROM seeds
LEFT JOIN garden_bed ON seeds.plant_id=garden_bed.plant_id

UNION

SELECT *
FROM seeds
RIGHT JOIN garden_bed ON seeds.plant_id=garden_bed.plant_id;


SELECT plant_name seed_id, expiration_date, quantity, reorder, space_number, date_planted, doing_well
FROM plant
INNER JOIN (
	SELECT seed_id, expiration_date, quantity, reorder, space_number, date_planted, doing_well, seeds.plant_id FROM seeds INNER JOIN garden_bed ON seeds.plant_id=garden_bed.plant_id) AS 
    planted_plants ON plant.plant_id=planted_plants.plant_id;

INSERT INTO seeds (expiration_date, quantity, reorder, plant_id)
VALUES ('2020-08-01', 100, 0, (SELECT plant_id FROM plant WHERE plant_name LIKE "Hosta"));

SELECT *
FROM seeds
LEFT JOIN garden_bed ON seeds.plant_id=garden_bed.plant_id

UNION ALL

SELECT *
FROM seeds
RIGHT JOIN garden_bed ON seeds.plant_id=garden_bed.plant_id;

