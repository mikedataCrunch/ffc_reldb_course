-- RESET: DROP DATABASE universe
-- BUILD: (1) Connect to postgres, (2) \i universe.sql
-- DUMP to cwd (after exiting postgres): pg_dump -U freecodecamp -F p -d universe -f universe.sql

-- Create the database named "universe"
CREATE DATABASE universe;

-- Connect to the database "universe"
\c universe;


CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,         -- Auto-increment primary key
    name VARCHAR(100) NOT NULL UNIQUE,    -- Galaxy name, unique and required
    size INT NOT NULL,                    -- Size of the galaxy (example attribute)
    number_of_stars BIGINT,               -- Number of stars in the galaxy, NOTE BIGINT due to INT limit
    description TEXT,                     -- Description of the galaxy
    discovered BOOLEAN NOT NULL           -- Whether the galaxy has been discovered or not
);

CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,           -- Auto-increment primary key
    name VARCHAR(100) NOT NULL UNIQUE,    -- Star name, unique and required
    galaxy_id INT REFERENCES galaxy(galaxy_id) ON DELETE CASCADE,  -- Foreign key referencing galaxy table
    luminosity NUMERIC(10, 2),            -- Luminosity (numeric type)
    mass INT NOT NULL,                    -- Mass of the star (in solar masses)
    is_active BOOLEAN NOT NULL            -- Whether the star is still active
);

CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,         -- Auto-increment primary key
    name VARCHAR(100) NOT NULL UNIQUE,    -- Planet name, unique and required
    star_id INT REFERENCES star(star_id) ON DELETE CASCADE,  -- Foreign key referencing star table
    distance_from_star NUMERIC(10, 2),    -- Distance from its star (in AU)
    mass INT NOT NULL,                    -- Mass of the planet (in Earth masses)
    has_life BOOLEAN NOT NULL             -- Whether the planet is known to support life
);

CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,           -- Auto-increment primary key
    name VARCHAR(100) NOT NULL UNIQUE,    -- Moon name, unique and required
    planet_id INT REFERENCES planet(planet_id) ON DELETE CASCADE,  -- Foreign key referencing planet table
    size INT NOT NULL,                    -- Size of the moon
    orbit_period NUMERIC(10, 2)           -- Orbit period in days
);

CREATE TABLE space_station (
    space_station_id SERIAL PRIMARY KEY,        -- Auto-increment primary key
    name VARCHAR(100) NOT NULL UNIQUE,    -- Space station name, unique and required
    capacity INT NOT NULL,                -- Number of people it can host
    is_operational BOOLEAN NOT NULL,      -- Whether the station is operational
    description TEXT                      -- Description of the space station
);

INSERT INTO galaxy (name, size, number_of_stars, description, discovered)
VALUES 
('Milky Way', 100000, 100000000000, 'Our home galaxy', TRUE),
('Andromeda', 220000, 1000000000000, 'Nearest major galaxy to the Milky Way', TRUE),
('Triangulum', 60000, 40000000000, 'A small spiral galaxy', TRUE),
('Sombrero Galaxy', 50000, 80000000000, 'Galaxy with a bright nucleus', TRUE),
('Whirlpool Galaxy', 30000, 100000000000, 'Famous for its spiral structure', TRUE),
('Cartwheel Galaxy', 150000, 50000000000, 'Galaxy with a distinctive ring shape', TRUE);


INSERT INTO star (name, galaxy_id, luminosity, mass, is_active)
VALUES 
('Sun', 1, 1.00, 1, TRUE),
('Alpha Centauri', 1, 1.519, 1.1, TRUE),
('Betelgeuse', 1, 126000, 15, TRUE),
('Rigel', 2, 120000, 17, TRUE),
('Sirius', 1, 25.4, 2.02, TRUE),
('Polaris', 1, 2500, 5.4, TRUE);

INSERT INTO planet (name, star_id, distance_from_star, mass, has_life)
VALUES 
('Earth', 1, 1.0, 1, TRUE),
('Mars', 1, 1.524, 0.11, FALSE),
('Jupiter', 1, 5.2, 318, FALSE),
('Proxima Centauri b', 2, 0.05, 1.17, FALSE),
('Betelgeuse b', 3, 1.0, 50, FALSE),
('Rigel I', 4, 0.9, 5, FALSE),
('Sirius B', 5, 0.2, 1.01, FALSE),
('Polaris b', 6, 0.2, 1.3, FALSE),
('Kepler-22b', 4, 0.85, 2.4, FALSE),
('GJ 1214 b', 4, 0.1, 6.55, FALSE),
('HD 189733 b', 4, 0.03, 1.15, FALSE),
('Gliese 581d', 2, 0.13, 0.9, FALSE);


INSERT INTO moon (name, planet_id, size, orbit_period)
VALUES 
('Moon', 1, 3474, 27.32),
('Phobos', 2, 22, 0.32),
('Deimos', 2, 12, 1.26),
('Europa', 3, 3121, 3.55),
('Ganymede', 3, 5268, 7.15),
('Callisto', 3, 4821, 16.69),
('Io', 3, 3643, 1.77),
('Proxima b I', 4, 1300, 2.05),
('Betelgeuse b I', 5, 1500, 20.02),
('Rigel I b', 6, 1500, 5.67),
('Sirius B I', 7, 1200, 1.67),
('Polaris b I', 8, 1000, 15.3),
('Kepler-22b I', 9, 1600, 10.5),
('GJ 1214 b I', 10, 1200, 11.3),
('HD 189733 b I', 11, 1800, 12.2),
('Gliese 581d I', 12, 1500, 20.1),
('Gliese 581d II', 12, 1400, 25.1),
('HD 189733 b II', 11, 1900, 30.0),
('Io II', 3, 3540, 8.99),
('Europa II', 3, 2970, 6.34);


INSERT INTO space_station (name, capacity, is_operational, description)
VALUES 
('International Space Station', 6, TRUE, 'A habitable artificial satellite in low Earth orbit'),
('Mir', 3, FALSE, 'A space station operated by the Soviet Union'),
('Lunar Gateway', 4, FALSE, 'A planned space station to be placed in lunar orbit');

