
DROP TABLE IF EXISTS Discovered
DROP TABLE IF EXISTS Monitor_Schedule;
DROP TABLE IF EXISTS Discovery;
DROP TABLE IF EXISTS Work;
DROP TABLE IF EXISTS Satellite;
DROP TABLE IF EXISTS Ground_Observatory;
DROP TABLE IF EXISTS Observatory;  
DROP TABLE IF EXISTS Observer;
DROP TABLE IF EXISTS Moon;         
DROP TABLE IF EXISTS Planet;       
DROP TABLE IF EXISTS Solar_System; 
DROP TABLE IF EXISTS Star;         
DROP TABLE IF EXISTS Star_Constellation;
DROP TABLE IF EXISTS Black_Hole;  
DROP TABLE IF EXISTS Galaxy;
DROP TABLE IF EXISTS Celestial_Body;

CREATE TABLE Galaxy (
    galaxy_name VARCHAR(30) PRIMARY KEY,
    diameter INT CHECK(diameter < 2 * 10e6),
    galaxy_type VARCHAR(11)
    CHECK ( galaxy_type IN ('elliptical', 'spiral', 'lenticular', 'irregular')),
    distance_from_earth INT CHECK (distance_from_earth < 13400000) NOT NULL
);

CREATE TABLE Celestial_Body (
    body_name VARCHAR(30) PRIMARY KEY,
    surface_temperature INT CHECK (surface_temperature > 0),
    distance_from_galaxy_center FLOAT CHECK(distance_from_galaxy_center < 10e5),
    mass_scientific_notation FLOAT CHECK (mass_scientific_notation BETWEEN 1.0 AND 10.0),
    mass_exp_10 INT CHECK (mass_exp_10 < 50),
    diameter BIGINT CHECK (diameter < 10e11)
);

CREATE TABLE Star_Constellation (
    constellation_name VARCHAR(30) PRIMARY KEY,
    no_stars INT CHECK (no_stars BETWEEN 3 AND 1500) NULL
);

CREATE TABLE Star(
    star_type VARCHAR(11)
    CHECK ( star_type IN ('sequence', 'dwarf', 'giant', 'supergiant')),
    star_power DECIMAL(18,9),
    color VARCHAR(7),
    constellation_name VARCHAR(30) REFERENCES Star_Constellation(constellation_name) NULL,
    galaxy_name VARCHAR(30) REFERENCES Galaxy(galaxy_name),
    star_name VARCHAR(30) PRIMARY KEY 
    REFERENCES Celestial_Body(body_name)
    ON UPDATE CASCADE
    ON DELETE CASCADE

);

ALTER TABLE Star
    ADD CONSTRAINT ENUMCHECK3
    CHECK (color IN ('blue', 'red', 'white','orange','yellow'));

CREATE TABLE Solar_System(
    solar_system_name VARCHAR(30) PRIMARY KEY,
    no_celestials INT CHECK(no_celestials < 10e6),
    center_star VARCHAR(30) REFERENCES Star(star_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE NULL,
    galaxy VARCHAR(30) REFERENCES Galaxy(galaxy_name) ON UPDATE CASCADE NULL
);


CREATE TABLE Planet(
    planet_name VARCHAR(30) PRIMARY KEY
    REFERENCES Celestial_Body(body_name)
    ON DELETE CASCADE,
    state_of_matter VARCHAR(6),
    percent_of_watter FLOAT CHECK (percent_of_watter BETWEEN 0.0 and 100.0),
    orbit_time FLOAT CHECK (orbit_time BETWEEN 0.0 and 100000.0),
    semi_major_axis FLOAT CHECK (semi_major_axis BETWEEN 0.0 and 10000.0),
    semi_minor_axis FLOAT CHECK (semi_minor_axis BETWEEN 0.0 and 10000.0),
    solar_system_name VARCHAR(30) 
    REFERENCES Solar_System(solar_system_name)
    ON UPDATE CASCADE NULL


);



CREATE TABLE Moon(
    moon_name VARCHAR(30) PRIMARY KEY 
    REFERENCES Celestial_Body(body_name),
    parent_planet_name VARCHAR(30) REFERENCES Planet(planet_name) ON DELETE CASCADE,
    percent_of_watter FLOAT CHECK (percent_of_watter BETWEEN 0.0 and 100.0),
    orbit_time FLOAT CHECK (orbit_time BETWEEN 0.0 and 10000.0),
    semi_major_axis FLOAT CHECK (semi_major_axis BETWEEN 0.0 and 1000000.0),
    semi_minor_axis FLOAT CHECK (semi_minor_axis BETWEEN 0.0 and 1000000.0)
    
);

CREATE TABLE Black_Hole
(
    black_hole_name VARCHAR(30) PRIMARY KEY
    REFERENCES Celestial_Body(body_name)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    galaxy VARCHAR(30) REFERENCES Galaxy(galaxy_name) NULL,
    type_ VARCHAR(13),
    spin FLOAT CHECK (spin BETWEEN 0.0 and 1.0)
);

ALTER TABLE Black_Hole
    ADD CONSTRAINT ENUMCHECK
    CHECK (type_ IN ('stellar', 'intermediate', 'supermassive', 'primordial'));

CREATE TABLE Observer (
    observer_id CHAR(11) 
    CHECK (
    observer_id LIKE '[A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
    )
    PRIMARY KEY,
    date_of_birth DATE NOT NULL,
    observer_name VARCHAR(20) NOT NULL CHECK 
    (
    observer_name LIKE '[A-Z]%'
    AND observer_name NOT LIKE '%[^A-Za-z]%'
    ), 
    observer_surname VARCHAR(20) NOT NULL CHECK 
    (
    observer_surname LIKE '[A-Z]%'
    AND observer_surname NOT LIKE '%[^A-Za-z]%'
    )
);
CREATE TABLE Observatory (
    observatory_id CHAR(8)
    CHECK(
    observatory_id LIKE '[SG][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'-- S for satelite and G for ground
    )

    PRIMARY KEY,
    boss_id CHAR(11) REFERENCES Observer(observer_id) 
);
ALTER TABLE Observatory
    ADD observatory_name VARCHAR(30) CHECK (observatory_name LIKE '[A-Z]%');

CREATE TABLE Ground_Observatory (
    observatory_id CHAR(8) PRIMARY KEY 
    REFERENCES Observatory(observatory_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,    
    city VARCHAR(30) CHECK (city LIKE '[A-Z]%') NOT NULL,
    country VARCHAR(12) CHECK (country LIKE '[A-Z]%') NOT NULL
);

CREATE TABLE Satellite (
    satellite_id CHAR(8) PRIMARY KEY 
    REFERENCES Observatory(observatory_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,   
    date_of_launch DATE CHECK (date_of_launch >= '1957-10-04') NOT NULL,
    orbiting_earth INT NOT NULL,
    velocity INT CHECK (velocity BETWEEN 0 AND 10e6) NULL,
    acceleration FLOAT CHECK (acceleration BETWEEN 0.0 AND 50.0) NULL
);

ALTER TABLE Satellite
    ALTER COLUMN orbiting_earth BIT;

CREATE TABLE Work(
    work_id INT PRIMARY KEY CHECK (work_id BETWEEN 1e7 AND 1e8-1),
    observer_id CHAR(11) REFERENCES Observer(observer_id) NOT NULL,
    observatory_id CHAR(8) REFERENCES Observatory(observatory_id) NOT NULL,
    date_of_start DATE NULL
    CHECK (date_of_start >= '1957-01-01'),
    date_of_end DATE NULL,  
    CHECK (date_of_end IS NULL OR date_of_end >= date_of_start)

);

CREATE TABLE Discovery(
    discovered_body_name VARCHAR(30) PRIMARY 
    KEY REFERENCES Celestial_Body(body_name) 
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    method VARCHAR(15),
    date_of_discovery DATE CHECK (date_of_discovery >= '1957-01-01'),
    observatory_id CHAR(8) REFERENCES Observatory(observatory_id)
    ON UPDATE CASCADE
);
ALTER TABLE Discovery
    ADD CONSTRAINT ENUMCHECK2
    CHECK (method IN ('Transit', 'Spectroscopy', 'Direct Imaging','Microlensing'));

CREATE TABLE Monitor_Schedule(
    monitor_id BIGINT CHECK (monitor_id BETWEEN 1e10 AND 1e11-1) PRIMARY KEY,
    celestial_name VARCHAR(30) REFERENCES Celestial_Body(body_name)
    ON DELETE CASCADE NOT NULL,
    observatory_id CHAR(8) REFERENCES Observatory(observatory_id)
    ON DELETE CASCADE NOT NULL,
    date_of_start CHAR(5) CHECK (date_of_start LIKE '[0-9][0-9]-[0-9][0-9]%') NOT NULL,
    date_of_end CHAR(5) CHECK (date_of_end LIKE '[0-9][0-9]-[0-9][0-9]%') NOT NULL
);

CREATE TABLE Discovered(
    observer_id CHAR(11) REFERENCES Observer(observer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    discovered_body_name VARCHAR(30) REFERENCES Discovery(discovered_body_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    PRIMARY KEY (observer_id, discovered_body_name)
);

