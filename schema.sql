CREATE DATABASE IF NOT EXISTS CS5200_Project;

USE CS5200_Project;

CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) UNIQUE NOT NULL,
    continent VARCHAR(32),
    population BIGINT,
    olympic_code VARCHAR(8) UNIQUE
);

CREATE TABLE city (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    population INT,
    latitude FLOAT,
    longitude FLOAT,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id) 
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE broadcaster (
    broadcaster_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) UNIQUE NOT NULL,
    type ENUM('TV', 'Radio', 'Online') NOT NULL
);

CREATE TABLE sport (
    sport_id INT AUTO_INCREMENT PRIMARY KEY,
    sport_name VARCHAR(64) UNIQUE NOT NULL,
    sport_type ENUM('Team', 'Individual') NOT NULL,
    category VARCHAR(32) NOT NULL,
    environment ENUM('Indoor', 'Outdoor') NOT NULL,
    equipment_required BOOLEAN
);

CREATE TABLE team (
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(32) UNIQUE NOT NULL,
    coach_name VARCHAR(32),
    no_of_players INT,
    establishment_year INT,
    country_id INT NOT NULL,
    sport_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id) 
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (sport_id) REFERENCES sport(sport_id) 
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE athlete (
    athlete_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    height FLOAT CHECK (height > 0),
    weight FLOAT CHECK (weight > 0),
    country_id INT NOT NULL,
    sport_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id) 
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (sport_id) REFERENCES sport(sport_id) 
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE record (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    type ENUM('WR', 'OR') NOT NULL,
    value VARCHAR(64) NOT NULL,
    date_achieved DATE NOT NULL,
    sport_id INT NOT NULL,
    FOREIGN KEY (sport_id) REFERENCES sport(sport_id) 
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE olympic_event (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(64) UNIQUE NOT NULL,
    event_year YEAR NOT NULL,
    edition VARCHAR(32),
    season ENUM('Summer', 'Winter') NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    city_id INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city(city_id) 
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- Olympic Event Sport Table (Many-to-Many Relationship)
CREATE TABLE olympic_event_sport (
    olympic_event_id INT NOT NULL,
    sport_id INT NOT NULL,
    PRIMARY KEY (olympic_event_id, sport_id),
    FOREIGN KEY (olympic_event_id) REFERENCES olympic_event(event_id) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (sport_id) REFERENCES sport(sport_id) 
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE medal (
    medal_id INT AUTO_INCREMENT PRIMARY KEY, 
    type ENUM('Gold', 'Silver', 'Bronze') NOT NULL
);

-- Broadcasted Ternary Relationship
CREATE TABLE broadcasted_(
    broadcaster_id INT,
    olympic_event_id INT,
    country_id INT,
    viewership BIGINT,
    PRIMARY KEY (broadcaster_id, olympic_event_id, country_id),
    FOREIGN KEY (broadcaster_id) REFERENCES broadcaster(broadcaster_id) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (olympic_event_id) REFERENCES olympic_event(event_id) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (country_id) REFERENCES country(country_id) 
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE athlete_win_history (
    athlete_id INT,
    sport_id INT,
    medal_id INT,
    win_date DATE NOT NULL,
    PRIMARY KEY (athlete_id, sport_id, medal_id, win_date),
    FOREIGN KEY (athlete_id) REFERENCES athlete(athlete_id) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (sport_id) REFERENCES sport(sport_id) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (medal_id) REFERENCES medal(medal_id) 
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE team_win_history (
    team_id INT,
    sport_id INT,
    medal_id INT,
    win_date DATE NOT NULL,
    PRIMARY KEY (team_id, sport_id, medal_id, win_date),
    FOREIGN KEY (team_id) REFERENCES team(team_id) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (sport_id) REFERENCES sport(sport_id) 
    ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (medal_id) REFERENCES medal(medal_id) 
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE users (
	user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(32) UNIQUE NOT NULL,
    password VARCHAR(32) NOT NULL,
	role ENUM('USER', 'ADMIN') NOT NULL,
    CONSTRAINT password_length CHECK (LENGTH(password) >= 8)
);

CREATE TABLE athelete_ranking (
	rank_id INT AUTO_INCREMENT PRIMARY KEY,
	world_rank INT NOT NULL,
    points INT NOT NULL,
    ranking_date DATE NOT NULL,
    federation VARCHAR(8) NOT NULL,
    athlete_id INT,
    sport_id INT,
    FOREIGN KEY (athlete_id) REFERENCES athlete(athlete_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (sport_id) REFERENCES sport(sport_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE team_ranking (
	rank_id INT AUTO_INCREMENT PRIMARY KEY,
	world_rank INT NOT NULL,
    points INT NOT NULL,
    ranking_date DATE NOT NULL,
    federation VARCHAR(8) NOT NULL,
    team_id INT,
	sport_id INT,
    FOREIGN KEY (team_id) REFERENCES team(team_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (sport_id) REFERENCES sport(sport_id) ON UPDATE CASCADE ON DELETE CASCADE
);



DELIMITER //
CREATE PROCEDURE add_athlete(
    p_first_name VARCHAR(32),
    p_last_name VARCHAR(32),
    p_date_of_birth DATE,
    p_gender ENUM('Male', 'Female', 'Other'),
    p_height FLOAT,
    p_weight FLOAT,
    p_country_id INT,
    p_sport_id INT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM athlete 
        WHERE first_name = p_first_name AND last_name = p_last_name AND date_of_birth = p_date_of_birth
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Athlete already exists.';
    ELSE
        INSERT INTO athlete (first_name, last_name, date_of_birth, gender, height, weight, country_id, sport_id)
        VALUES (p_first_name, p_last_name, p_date_of_birth, p_gender, p_height, p_weight, p_country_id, p_sport_id);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_team(
    p_team_name VARCHAR(32),
    p_coach_name VARCHAR(32),
    p_no_of_players INT,
    p_establishment_year INT,
    p_country_id INT,
    p_sport_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM team WHERE team_name = p_team_name AND establishment_year = p_establishment_year AND country_id = p_country_id AND sport_id = p_sport_id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Team already exists.';
    ELSE
        INSERT INTO team (team_name, coach_name, no_of_players, establishment_year, country_id, sport_id)
        VALUES (p_team_name, p_coach_name, p_no_of_players, p_establishment_year, p_country_id, p_sport_id);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_event(
    p_EventName VARCHAR(64),
    p_Year INT,
    p_edition VARCHAR(32),
    p_Season ENUM('Summer', 'Winter'),
    p_StartDate DATE,
    p_EndDate DATE,
    p_HostCityID INT
)
BEGIN
	IF EXISTS (SELECT 1 FROM olympic_event WHERE event_name = p_EventName AND start_date = p_StartDate AND end_date = p_EndDate AND city_id = p_HostCityID) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Event already exists.';
    ELSE
		INSERT INTO olympic_event (event_name, event_year, edition, season, start_date, end_date, city_id)
		VALUES (p_EventName, p_Year, p_edition, p_Season, p_StartDate, p_EndDate, p_HostCityID);
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_broadcaster_details(
    p_name VARCHAR(64),
    p_BroadcastType ENUM('TV', 'Radio', 'Online')
)
BEGIN
	IF EXISTS (SELECT 1 FROM broadcaster WHERE name = p_name AND type = p_BroadcastType) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Broadcaster already exists.';
    ELSE
		INSERT INTO broadcaster (name, type)
		VALUES (p_name, p_BroadcastType);
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_broadcast_details(
    p_broadcaster_id INT,
    p_EventID INT,
    p_CountryID INT,
    p_Viewership LONG
)
BEGIN
IF EXISTS (SELECT 1 FROM broadcasted_ WHERE broadcaster_id = p_broadcaster_id AND olympic_event_id = p_EventID AND country_id = p_CountryID) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Broadcast details exists.';
    ELSE
		INSERT INTO broadcasted_(broadcaster_id, olympic_event_id, country_id, viewership)
		VALUES (p_broadcaster_id, p_EventID, p_CountryID, p_Viewership);
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_country(
    p_name VARCHAR(64),
    p_continent VARCHAR(32),
    p_population BIGINT,
    p_olympic_code VARCHAR(8)
)
BEGIN
    IF EXISTS (SELECT 1 FROM country WHERE name = p_name OR olympic_code = p_olympic_code) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Country already exists.';
    ELSE
        INSERT INTO country (name, continent, population, olympic_code)
        VALUES (p_name, p_continent, p_population, p_olympic_code);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_city(
    p_name VARCHAR(64),
    p_population INT,
    p_latitude FLOAT,
    p_longitude FLOAT,
    p_country_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM city WHERE name = p_name AND country_id = p_country_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'City already exists.';
    ELSE
        INSERT INTO city (name, population, latitude, longitude, country_id)
        VALUES (p_name, p_population, p_latitude, p_longitude, p_country_id);
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE add_sport(
    p_sport_name VARCHAR(64),
    p_sport_type ENUM('Team', 'Individual'),
    p_category VARCHAR(32),
    p_environment ENUM('Indoor', 'Outdoor'),
    p_equipment_required BOOLEAN
)
BEGIN
    IF EXISTS (SELECT 1 FROM sport WHERE sport_name = p_sport_name AND
    sport_type = p_sport_type AND
    category = p_category AND
    environment = p_environment AND
    equipment_required = p_equipment_required) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sport already exists.';
    ELSE
        INSERT INTO sport (sport_name, sport_type, category, environment, equipment_required)
        VALUES (p_sport_name, p_sport_type, p_category, p_environment, p_equipment_required);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_record(
    p_type ENUM('WR', 'OR'),
    p_value VARCHAR(64),
    p_date_achieved DATE,
    p_sport_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM record WHERE type = p_type AND
    value = p_value AND 
    date_achieved = p_date_achieved AND
    sport_id = p_sport_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Record already exists.';
    ELSE
        INSERT INTO record (type, value, date_achieved, sport_id)
        VALUES (p_type, p_value, p_date_achieved, p_sport_id);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_sport_to_event(
    p_olympic_id INT,
    p_sport_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM olympic_event_sport WHERE olympic_event_id = p_olympic_id AND sport_id = p_sport_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sport already exists the event.';
    ELSE
        INSERT INTO olympic_event_sport (olympic_event_id, sport_id)
        VALUES (p_olympic_id, p_sport_id);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_athlete_win_record(
    p_athlete_id INT,
    p_sport_id INT,
    p_medal_id INT,
    p_win_date DATE
)
BEGIN
    IF EXISTS (SELECT 1 FROM athlete_win_history WHERE athlete_id = p_athlete_id AND
    sport_id = p_sport_id AND 
    medal_id = p_medal_id AND
    win_date = p_win_date) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Athlete wrecord already exists.';
    ELSE
        INSERT INTO athlete_win_history (athlete_id, sport_id, medal_id, win_date)
        VALUES (p_athlete_id, p_sport_id, p_medal_id, p_win_date);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_team_win_record(
    p_team_id INT,
    p_sport_id INT,
    p_medal_id INT,
    p_win_date DATE
)
BEGIN
    IF EXISTS (SELECT 1 FROM team_win_history WHERE team_id = p_team_id AND
    sport_id = p_sport_id AND 
    medal_id = p_medal_id AND
    win_date = p_win_date) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Team wrecord already exists.';
    ELSE
        INSERT INTO team_win_history (team_id, sport_id, medal_id, win_date)
        VALUES (p_team_id, p_sport_id, p_medal_id, p_win_date);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_user(
    p_username VARCHAR(32),
    p_password VARCHAR(32),
	p_role ENUM('USER', 'ADMIN')
)
BEGIN
    IF EXISTS (SELECT 1 FROM users WHERE username = p_username AND
    password = p_password AND 
    role = p_role) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User already exists.';
    ELSE
        INSERT INTO users (username, password, role)
        VALUES (p_username, p_password, p_role);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_athelete_ranking(
    p_world_rank INT,
    p_points INT,
    p_ranking_date DATE,
    p_federation VARCHAR(8),
    p_athlete_id INT,
    p_sport_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM athelete_ranking WHERE p_world_rank = world_rank AND
    p_points  = points AND
    p_ranking_date = ranking_date AND
    p_federation = federation AND
    p_athlete_id = athlete_id AND
    p_sport_id = sport_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rank record already exists.';
    ELSE
        INSERT INTO athelete_ranking (world_rank, points, ranking_date, federation, athlete_id, sport_id)
        VALUES (p_world_rank, p_points, p_ranking_date, p_federation, p_athlete_id, p_sport_id);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_team_ranking(
    p_world_rank INT,
    p_points INT,
    p_ranking_date DATE,
    p_federation VARCHAR(8),
    p_team_id INT,
    p_sport_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM team_ranking WHERE p_world_rank = world_rank AND
    p_points  = points AND
    p_ranking_date = ranking_date AND
    p_federation = federation AND
    p_team_id = team_id AND
    p_sport_id = sport_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rank record already exists.';
    ELSE
        INSERT INTO team_ranking (world_rank, points, ranking_date, federation, team_id, sport_id)
        VALUES (p_world_rank, p_points, p_ranking_date, p_federation, p_team_id, p_sport_id);
    END IF;
END //
DELIMITER ;


-- Stored procedure to get data from the country table
DELIMITER $$
CREATE PROCEDURE get_countries()
BEGIN
    SELECT * FROM country;
END$$
DELIMITER ;

-- Stored procedure to get data from the city table
DELIMITER $$
CREATE PROCEDURE get_cities()
BEGIN
    SELECT 
        c.city_id,
        c.name AS city_name,
        c.population AS city_population,
        c.latitude,
        c.longitude,
        co.name AS country_name
    FROM 
        city AS c
    INNER JOIN
        country AS co ON c.country_id = co.country_id;
END$$
DELIMITER ;

-- Stored procedure to get data from the broadcaster table
DELIMITER $$
CREATE PROCEDURE get_broadcasters()
BEGIN
    SELECT * FROM broadcaster;
END$$
DELIMITER ;

-- Stored procedure to get data from the sport table
DELIMITER $$
CREATE PROCEDURE get_sports()
BEGIN
    SELECT * FROM sport;
END$$
DELIMITER ;

-- Stored procedure to get data from the team table
DELIMITER $$
CREATE PROCEDURE get_teams()
BEGIN
    SELECT 
        t.team_id,
        t.team_name,
        t.coach_name,
        t.no_of_players,
        t.establishment_year,
        c.name AS country_name,
        s.sport_name
    FROM 
        team AS t
    INNER JOIN
        country AS c ON t.country_id = c.country_id
    INNER JOIN
        sport AS s ON t.sport_id = s.sport_id;
END$$
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_team_details(p_team_id INT)
BEGIN
    SELECT 
        t.team_id,
        t.team_name,
        t.coach_name,
        t.no_of_players,
        t.establishment_year,
        c.name AS country_name,
        s.sport_name
    FROM 
        team AS t
    INNER JOIN
        country AS c ON t.country_id = c.country_id
    INNER JOIN
        sport AS s ON t.sport_id = s.sport_id
    WHERE 
        t.team_id = p_team_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_teams_by_sports(p_sport_id INT)
BEGIN
    SELECT 
        t.team_id,
        t.team_name,
        t.coach_name,
        t.no_of_players,
        t.establishment_year,
        c.name AS country_name,
        s.sport_name
    FROM 
        team AS t
    INNER JOIN
        country AS c ON t.country_id = c.country_id
    INNER JOIN
        sport AS s ON t.sport_id = s.sport_id
    WHERE 
        t.sport_id = p_sport_id;
END //
DELIMITER ;


-- Stored procedure to get data from the athlete table
DELIMITER $$
CREATE PROCEDURE get_athletes()
BEGIN
    SELECT 
        a.athlete_id,
        a.first_name,
        a.last_name,
        a.date_of_birth,
        a.gender,
        a.height,
        a.weight,
        c.name AS country_name,
        c.olympic_code AS country_code,
        s.sport_name
    FROM 
        athlete AS a
    INNER JOIN
        country AS c ON a.country_id = c.country_id
    INNER JOIN
        sport AS s ON a.sport_id = s.sport_id;
END$$
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_athletes_by_sports(p_sport_id INT)
BEGIN
    SELECT 
        a.athlete_id,
        a.first_name,
        a.last_name,
        a.date_of_birth,
        a.gender,
        a.height,
        a.weight,
        c.name AS country_name,
        s.sport_name
    FROM 
        athlete AS a
    INNER JOIN
        country AS c ON a.country_id = c.country_id
    INNER JOIN
        sport AS s ON a.sport_id = s.sport_id
    WHERE 
        a.sport_id = p_sport_id;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE get_athlete_details(p_athlete_id INT)
BEGIN
    SELECT 
        a.athlete_id,
        a.first_name,
        a.last_name,
        a.date_of_birth,
        a.gender,
        a.height,
        a.weight,
        c.name AS country_name,
        s.sport_name
    FROM 
        athlete AS a
    INNER JOIN
        country AS c ON a.country_id = c.country_id
    INNER JOIN
        sport AS s ON a.sport_id = s.sport_id
    WHERE 
        a.athlete_id = p_athlete_id;
END //
DELIMITER ;

-- Stored procedure to get data from the record table
DELIMITER $$
CREATE PROCEDURE get_sport_records(p_sport_id INT)
BEGIN
    SELECT 
        r.record_id,
        r.type AS record_type,
        r.value AS record_value,
        r.date_achieved,
        s.sport_name
    FROM 
        record AS r
    INNER JOIN
        sport AS s ON r.sport_id = s.sport_id
	WHERE s.sport_id = p_sport_id;        
END$$
DELIMITER ;

-- Stored procedure to get data from the olympic_event table
DELIMITER $$
CREATE PROCEDURE get_olympic_events()
BEGIN
    SELECT 
        e.event_id,
        e.event_name,
        e.event_year,
        e.edition,
        e.season,
        e.start_date,
        e.end_date,
        c.name AS city_name
    FROM 
        olympic_event AS e
    INNER JOIN
        city AS c ON e.city_id = c.city_id;
END$$
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_events_by_country(p_country_id INT)
BEGIN
    SELECT 
        e.event_id,
        e.event_name,
        e.event_year,
        e.edition,
        e.season,
        e.start_date,
        e.end_date,
        c.name AS city_name,
        co.name AS country_name
    FROM 
        olympic_event AS e
    INNER JOIN
        city AS c ON e.city_id = c.city_id
    INNER JOIN
        country AS co ON c.country_id = co.country_id
    WHERE 
        co.country_id = p_country_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_events_by_year(p_year INT)
BEGIN
    SELECT 
        e.event_id,
        e.event_name,
        e.event_year,
        e.edition,
        e.season,
        e.start_date,
        e.end_date,
        c.name AS city_name,
        co.name AS country_name
    FROM 
        olympic_event AS e
    INNER JOIN
        city AS c ON e.city_id = c.city_id
    INNER JOIN
        country AS co ON c.country_id = co.country_id
    WHERE 
        e.event_year = p_year;
END //
DELIMITER ;


-- Stored procedure to get data from the olympic_event_sport table
DELIMITER $$
CREATE PROCEDURE get_sports_in_olympic_events(p_event_id INT)
BEGIN
    SELECT 
        oes.olympic_event_id,
        oe.event_name,
        s.sport_name
    FROM 
        olympic_event_sport AS oes
    INNER JOIN
        olympic_event AS oe ON oes.olympic_event_id = oe.event_id
    INNER JOIN
        sport AS s ON oes.sport_id = s.sport_id
	WHERE oe.event_id = p_event_id;
END$$
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_events_by_sports(p_sport_id INT)
BEGIN
    SELECT 
        e.event_id,
        e.event_name,
        e.event_year,
        e.edition,
        e.season,
        e.start_date,
        e.end_date,
        s.sport_name,
        c.name AS city_name
    FROM 
        olympic_event AS e
    INNER JOIN
        olympic_event_sport AS oes ON e.event_id = oes.olympic_event_id
    INNER JOIN
        sport AS s ON oes.sport_id = s.sport_id
    INNER JOIN
        city AS c ON e.city_id = c.city_id
    WHERE 
        s.sport_id = p_sport_id;
END //
DELIMITER ;


-- Stored procedure to get data from the medal table
DELIMITER $$
CREATE PROCEDURE get_medals()
BEGIN
    SELECT * FROM medal;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE get_most_medal_winning_countries_by_year(p_year INT)
BEGIN
    SELECT 
        c.name AS country_name,
        m.type AS medal_type,
        COUNT(*) AS total_medals
    FROM (
        -- Combine athlete and team wins
        SELECT 
            a.country_id,
            awh.medal_id
        FROM 
            athlete_win_history AS awh
        INNER JOIN
            athlete AS a ON awh.athlete_id = a.athlete_id
            
        UNION ALL

        SELECT 
            t.country_id,
            twh.medal_id
        FROM 
            team_win_history AS twh
        INNER JOIN
            team AS t ON twh.team_id = t.team_id
    ) AS all_wins
    INNER JOIN
        country AS c ON all_wins.country_id = c.country_id
    INNER JOIN
        medal AS m ON all_wins.medal_id = m.medal_id
    INNER JOIN
        olympic_event AS oe ON oe.event_year = p_year
    WHERE 
        oe.event_year = p_year
    GROUP BY 
        c.country_id, m.type
    ORDER BY 
        total_medals DESC, m.type;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE get_medals_won_by_country_in_indoor_sports()
BEGIN
    SELECT 
        c.name AS country_name,
        m.type AS medal_type,
        COUNT(*) AS total_medals
    FROM (
        SELECT 
            a.country_id,
            awh.medal_id,
            s.environment
        FROM 
            athlete_win_history AS awh
        INNER JOIN
            athlete AS a ON awh.athlete_id = a.athlete_id
        INNER JOIN
            sport AS s ON awh.sport_id = s.sport_id
        UNION ALL
        SELECT 
            t.country_id,
            twh.medal_id,
            s.environment
        FROM 
            team_win_history AS twh
        INNER JOIN
            team AS t ON twh.team_id = t.team_id
        INNER JOIN
            sport AS s ON twh.sport_id = s.sport_id
    ) AS all_wins
    INNER JOIN
        country AS c ON all_wins.country_id = c.country_id
    INNER JOIN
        medal AS m ON all_wins.medal_id = m.medal_id
    WHERE 
        all_wins.environment = 'Indoor'
    GROUP BY 
        c.country_id, m.type
    ORDER BY 
        total_medals DESC, m.type;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE get_medals_won_by_country_in_outdoor_sports()
BEGIN
    SELECT 
        c.name AS country_name,
        m.type AS medal_type,
        COUNT(*) AS total_medals
    FROM (
        SELECT 
            a.country_id,
            awh.medal_id,
            s.environment
        FROM 
            athlete_win_history AS awh
        INNER JOIN
            athlete AS a ON awh.athlete_id = a.athlete_id
        INNER JOIN
            sport AS s ON awh.sport_id = s.sport_id
        UNION ALL
        SELECT 
            t.country_id,
            twh.medal_id,
            s.environment
        FROM 
            team_win_history AS twh
        INNER JOIN
            team AS t ON twh.team_id = t.team_id
        INNER JOIN
            sport AS s ON twh.sport_id = s.sport_id
    ) AS all_wins
    INNER JOIN
        country AS c ON all_wins.country_id = c.country_id
    INNER JOIN
        medal AS m ON all_wins.medal_id = m.medal_id
    WHERE 
        all_wins.environment = 'Outdoor'
    GROUP BY 
        c.country_id, m.type
    ORDER BY 
        total_medals DESC, m.type;
END$$
DELIMITER ;

-- Stored procedure to get data from the broadcasted_table
DELIMITER $$
CREATE PROCEDURE get_broadcast_details()
BEGIN
    SELECT 
        bi.broadcaster_id,
        br.name AS broadcaster_name,
        bi.olympic_event_id,
        oe.event_name AS olympic_event_name,
        bi.country_id,
        c.name AS country_name,
        bi.viewership
    FROM 
        broadcasted_ AS bi
    INNER JOIN
        broadcaster AS br ON bi.broadcaster_id = br.broadcaster_id
    INNER JOIN
        olympic_event AS oe ON bi.olympic_event_id = oe.event_id
    INNER JOIN
        country AS c ON bi.country_id = c.country_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE get_broadcast_details_by_year(p_year INT)
BEGIN
    SELECT 
        bi.broadcaster_id,
        br.name AS broadcaster_name,
        bi.olympic_event_id,
        oe.event_name AS olympic_event_name,
        oe.event_year AS event_year,
        bi.country_id,
        c.name AS country_name,
        bi.viewership
    FROM 
        broadcasted_ AS bi
    INNER JOIN
        broadcaster AS br ON bi.broadcaster_id = br.broadcaster_id
    INNER JOIN
        olympic_event AS oe ON bi.olympic_event_id = oe.event_id
    INNER JOIN
        country AS c ON bi.country_id = c.country_id
    WHERE 
        oe.event_year = p_year;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE get_broadcast_details_by_event(p_event_id INT)
BEGIN
    SELECT 
        bi.broadcaster_id,
        br.name AS broadcaster_name,
        bi.olympic_event_id,
        oe.event_name AS olympic_event_name,
        bi.country_id,
        c.name AS country_name,
        bi.viewership
    FROM 
        broadcasted_ AS bi
    INNER JOIN
        broadcaster AS br ON bi.broadcaster_id = br.broadcaster_id
    INNER JOIN
        olympic_event AS oe ON bi.olympic_event_id = oe.event_id
    INNER JOIN
        country AS c ON bi.country_id = c.country_id
    WHERE 
        bi.olympic_event_id = p_event_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE get_event_with_highest_broadcast_viewership()
BEGIN
    SELECT 
        oe.event_id,
        oe.event_name,
        SUM(bi.viewership) AS total_viewership,
        br.name AS broadcaster_name,
        c.name AS country_name
    FROM 
        broadcasted_ AS bi
    INNER JOIN
        olympic_event AS oe ON bi.olympic_event_id = oe.event_id
    INNER JOIN
        broadcaster AS br ON bi.broadcaster_id = br.broadcaster_id
    INNER JOIN
        country AS c ON bi.country_id = c.country_id
    GROUP BY 
        oe.event_id, br.name, c.name
    ORDER BY 
        total_viewership DESC
    LIMIT 1;
END$$
DELIMITER ;


-- Stored procedure to get data from the athlete_win_history table
DELIMITER $$
CREATE PROCEDURE get_athlete_win_history()
BEGIN
    SELECT 
        awh.athlete_id,
        CONCAT(a.first_name, ' ', a.last_name) AS athlete_name,
        awh.sport_id,
        s.sport_name,
        awh.medal_id,
        m.type AS medal_type,
        awh.win_date
    FROM 
        athlete_win_history AS awh
    INNER JOIN
        athlete AS a ON awh.athlete_id = a.athlete_id
    INNER JOIN
        sport AS s ON awh.sport_id = s.sport_id
    INNER JOIN
        medal AS m ON awh.medal_id = m.medal_id;
END$$
DELIMITER ;

-- Stored procedure to get data from the team_win_history table
DELIMITER $$
CREATE PROCEDURE get_team_win_history()
BEGIN
    SELECT 
        twh.team_id,
        t.team_name,
        twh.sport_id,
        s.sport_name,
        twh.medal_id,
        m.type AS medal_type,
        twh.win_date
    FROM 
        team_win_history AS twh
    INNER JOIN
        team AS t ON twh.team_id = t.team_id
    INNER JOIN
        sport AS s ON twh.sport_id = s.sport_id
    INNER JOIN
        medal AS m ON twh.medal_id = m.medal_id;
END$$
DELIMITER ;

-- Stored procedure to get data from the users table
DELIMITER $$
CREATE PROCEDURE get_users()
BEGIN
    SELECT * FROM users;
END$$
DELIMITER ;

-- Stored procedure to get data from the athlete_ranking table
DELIMITER $$
CREATE PROCEDURE get_athletes_ranking()
BEGIN
    SELECT 
        ar.rank_id,
        ar.world_rank,
        ar.points,
        ar.ranking_date,
        ar.federation,
        ar.athlete_id,
        CONCAT(a.first_name, ' ', a.last_name) AS athlete_name,
        ar.sport_id,
        s.sport_name
    FROM 
        athelete_ranking AS ar
    INNER JOIN
        athlete AS a ON ar.athlete_id = a.athlete_id
    INNER JOIN
        sport AS s ON ar.sport_id = s.sport_id
    ORDER BY 
        ar.world_rank;
END$$
DELIMITER ;

-- Stored procedure to get data from the team_ranking table
DELIMITER $$
CREATE PROCEDURE get_teams_ranking()
BEGIN
    SELECT 
        tr.rank_id,
        tr.world_rank,
        tr.points,
        tr.ranking_date,
        tr.federation,
        tr.team_id,
        t.team_name,
        tr.sport_id,
        s.sport_name
    FROM 
        team_ranking AS tr
    INNER JOIN
        team AS t ON tr.team_id = t.team_id
    INNER JOIN
        sport AS s ON tr.sport_id = s.sport_id
    ORDER BY 
        tr.world_rank;
END$$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE get_no_of_sports_participated_by_a_country_per_event(p_country_id INT)
BEGIN
    SELECT 
        c.name AS country_name,
        oe.event_name AS olympic_event_name,
        oe.event_year AS event_year,
        COUNT(DISTINCT all_participation.sport_id) AS total_sports
    FROM (
		SELECT 
            a.country_id,
            a.sport_id,
            oes.olympic_event_id
        FROM 
            athlete AS a
        INNER JOIN
            olympic_event_sport AS oes ON a.sport_id = oes.sport_id
        UNION ALL
        SELECT 
            t.country_id,
            t.sport_id,
            oes.olympic_event_id
        FROM 
            team AS t
        INNER JOIN
            olympic_event_sport AS oes ON t.sport_id = oes.sport_id
    ) AS all_participation
    INNER JOIN
        olympic_event AS oe ON all_participation.olympic_event_id = oe.event_id
    INNER JOIN
        country AS c ON all_participation.country_id = c.country_id
    WHERE 
        c.country_id = p_country_id
    GROUP BY 
        c.country_id, oe.event_id
    ORDER BY 
        oe.event_year;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE update_country(
    p_country_id INT,
    p_name VARCHAR(64),
    p_continent VARCHAR(32),
    p_population BIGINT,
    p_olympic_code VARCHAR(8)
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM country WHERE country_id = p_country_id
    ) THEN
        UPDATE country
        SET 
            name = p_name,
            continent = p_continent,
            population = p_population,
            olympic_code = p_olympic_code
        WHERE 
            country_id = p_country_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Country does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE update_city(
    p_city_id INT,
    p_name VARCHAR(64),
    p_population INT,
    p_latitude FLOAT,
    p_longitude FLOAT,
    p_country_id INT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM city WHERE city_id = p_city_id
    ) THEN
        UPDATE city
        SET 
            name = p_name,
            population = p_population,
            latitude = p_latitude,
            longitude = p_longitude,
            country_id = p_country_id
        WHERE 
            city_id = p_city_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'City does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE update_athlete(
    p_athlete_id INT,
    p_first_name VARCHAR(32),
    p_last_name VARCHAR(32),
    p_date_of_birth DATE,
    p_gender ENUM('Male', 'Female', 'Other'),
    p_height FLOAT,
    p_weight FLOAT,
    p_country_id INT,
    p_sport_id INT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM athlete WHERE athlete_id = p_athlete_id
    ) THEN
        UPDATE athlete
        SET 
            first_name = p_first_name,
            last_name = p_last_name,
            date_of_birth = p_date_of_birth,
            gender = p_gender,
            height = p_height,
            weight = p_weight,
            country_id = p_country_id,
            sport_id = p_sport_id
        WHERE 
            athlete_id = p_athlete_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Athlete does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE update_team(
    p_team_id INT,
    p_team_name VARCHAR(32),
    p_coach_name VARCHAR(32),
    p_no_of_players INT,
    p_establishment_year INT,
    p_country_id INT,
    p_sport_id INT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM team WHERE team_id = p_team_id
    ) THEN
        UPDATE team
        SET 
            team_name = p_team_name,
            coach_name = p_coach_name,
            no_of_players = p_no_of_players,
            establishment_year = p_establishment_year,
            country_id = p_country_id,
            sport_id = p_sport_id
        WHERE 
            team_id = p_team_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Team does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE update_olympic_event(
    p_event_id INT,
    p_event_name VARCHAR(64),
    p_year YEAR,
    p_edition VARCHAR(32),
    p_season ENUM('Summer', 'Winter'),
    p_start_date DATE,
    p_end_date DATE,
    p_city_id INT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM olympic_event WHERE event_id = p_event_id
    ) THEN
        UPDATE olympic_event
        SET 
            event_name = p_event_name,
            event_year = p_year,
            edition = p_edition,
            season = p_season,
            start_date = p_start_date,
            end_date = p_end_date,
            city_id = p_city_id
        WHERE 
            event_id = p_event_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Olympic event does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE update_sport(
    p_sport_id INT,
    p_sport_name VARCHAR(64),
    p_sport_type ENUM('Team', 'Individual'),
    p_category VARCHAR(32),
    p_environment ENUM('Indoor', 'Outdoor'),
    p_equipment_required BOOLEAN
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM sport WHERE sport_id = p_sport_id
    ) THEN
        UPDATE sport
        SET 
            sport_name = p_sport_name,
            sport_type = p_sport_type,
            category = p_category,
            environment = p_environment,
            equipment_required = p_equipment_required
        WHERE 
            sport_id = p_sport_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sport does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE update_athlete_ranking(
    p_rank_id INT,
    p_world_rank INT,
    p_points INT,
    p_ranking_date DATE,
    p_federation VARCHAR(8)
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM athelete_ranking WHERE rank_id = p_rank_id
    ) THEN
        UPDATE athelete_ranking
        SET 
            world_rank = p_world_rank,
            points = p_points,
            ranking_date = p_ranking_date,
            federation = p_federation
        WHERE 
            rank_id = p_rank_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Athlete ranking does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE update_team_ranking(
    p_rank_id INT,
    p_world_rank INT,
    p_points INT,
    p_ranking_date DATE,
    p_federation VARCHAR(8)
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM team_ranking WHERE rank_id = p_rank_id
    ) THEN
        UPDATE team_ranking
        SET 
            world_rank = p_world_rank,
            points = p_points,
            ranking_date = p_ranking_date,
            federation = p_federation
        WHERE 
            rank_id = p_rank_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Team ranking does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE update_sport_record(
    p_record_id INT,
    p_type ENUM('WR', 'OR'),
    p_value VARCHAR(64),
    p_date_achieved DATE,
    p_sport_id INT
)
BEGIN
    -- Check if the record exists
    IF EXISTS (
        SELECT 1 FROM record WHERE record_id = p_record_id
    ) THEN
        -- Perform the update if the record exists
        UPDATE record
        SET 
            type = p_type,
            value = p_value,
            date_achieved = p_date_achieved,
            sport_id = p_sport_id
        WHERE 
            record_id = p_record_id;
    ELSE
        -- Signal an error if the record does not exist
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Record does not exist.';
    END IF;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE delete_country(p_country_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM country WHERE country_id = p_country_id
    ) THEN
        DELETE FROM country
        WHERE country_id = p_country_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Country does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE delete_city(p_city_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM city WHERE city_id = p_city_id
    ) THEN
        DELETE FROM city
        WHERE city_id = p_city_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'City does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE delete_broadcaster(p_broadcaster_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM broadcaster WHERE broadcaster_id = p_broadcaster_id
    ) THEN
        DELETE FROM broadcaster
        WHERE broadcaster_id = p_broadcaster_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Broadcaster does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE delete_sport(p_sport_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM sport WHERE sport_id = p_sport_id
    ) THEN
        DELETE FROM sport
        WHERE sport_id = p_sport_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sport does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE delete_team(p_team_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM team WHERE team_id = p_team_id
    ) THEN
        DELETE FROM team
        WHERE team_id = p_team_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Team does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE delete_athlete(p_athlete_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM athlete WHERE athlete_id = p_athlete_id
    ) THEN
        DELETE FROM athlete
        WHERE athlete_id = p_athlete_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Athlete does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE delete_record(p_record_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM record WHERE record_id = p_record_id
    ) THEN
        DELETE FROM record
        WHERE record_id = p_record_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Record does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE delete_olympic_event(p_event_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM olympic_event WHERE event_id = p_event_id
    ) THEN
        DELETE FROM olympic_event
        WHERE event_id = p_event_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Olympic event does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE delete_olympic_sport_event(p_olympic_event_id INT, p_sport_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM olympic_event_sport 
        WHERE olympic_event_id = p_olympic_event_id AND sport_id = p_sport_id
    ) THEN
        DELETE FROM olympic_event_sport
        WHERE olympic_event_id = p_olympic_event_id AND sport_id = p_sport_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Olympic event sport combination does not exist.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE delete_user(p_user_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM users WHERE user_id = p_user_id
    ) THEN
        DELETE FROM users
        WHERE user_id = p_user_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User does not exist.';
    END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE authenticate_user(
    IN p_username VARCHAR(32), 
    IN p_password VARCHAR(32), 
    OUT user_role VARCHAR(10) 
)
BEGIN    
    SELECT role
    INTO user_role
    FROM users
    WHERE username = p_username AND password = p_password
    LIMIT 1;

    IF user_role IS NULL THEN
        SET user_role = NULL;
    END IF;
END$$
DELIMITER ;

-- Insert records into `country`
INSERT INTO country (name, continent, population, olympic_code) VALUES
('USA', 'North America', 331000000, 'USA'),
('Canada', 'North America', 38000000, 'CAN'),
('China', 'Asia', 1441000000, 'CHN'),
('Japan', 'Asia', 126000000, 'JPN'),
('Germany', 'Europe', 83000000, 'GER'),
('Australia', 'Oceania', 25000000, 'AUS'),
('India', 'Asia', 1391000000, 'IND'),
('Russia', 'Europe', 146000000, 'RUS'),
('Brazil', 'South America', 213000000, 'BRA'),
('South Africa', 'Africa', 59000000, 'RSA'),
('France', 'Europe', 67000000, 'FRA'),
('Italy', 'Europe', 60000000, 'ITA');

-- Insert records into `city`
INSERT INTO city (name, population, latitude, longitude, country_id) VALUES
('Los Angeles', 3970000, 34.0522, -118.2437, 1),
('New York', 8419600, 40.7128, -74.0060, 1),
('Toronto', 2731571, 43.6511, -79.3837, 2),
('Tokyo', 13929286, 35.6895, 139.6917, 4),
('Berlin', 3644826, 52.5200, 13.4050, 5),
('Sydney', 5312163, -33.8688, 151.2093, 6),
('Mumbai', 20185064, 19.0760, 72.8777, 7),
('Moscow', 12506468, 55.7558, 37.6173, 8),
('Rio de Janeiro', 6748000, -22.9068, -43.1729, 9),
('Cape Town', 433688, -33.9249, 18.4241, 10),
('Paris', 2148327, 48.8566, 2.3522, 11),
('Rome', 2872800, 41.9028, 12.4964, 12);

-- Insert records into `broadcaster`
INSERT INTO broadcaster (name, type) VALUES
('NBC', 'TV'),
('CBC', 'TV'),
('Tencent', 'Online'),
('NHK', 'TV'),
('ARD', 'Radio'),
('ESPN', 'Online'),
('Sky Sports', 'TV'),
('Fox Sports', 'Radio'),
('Al Jazeera', 'TV'),
('BBC', 'Radio'),
('Eurosport', 'Online'),
('Star Sports', 'TV');

-- Insert records into `sport`
INSERT INTO sport (sport_name, category, sport_type, environment, equipment_required) VALUES
('Basketball', 'Ball Game', 'Team', 'Indoor', TRUE),
('Soccer', 'Field Game', 'Team', 'Outdoor', TRUE),
('Swimming', 'Water Sport', 'Individual', 'Indoor', TRUE),
('Athletics', 'Track & Field', 'Individual', 'Outdoor', FALSE),
('Gymnastics', 'Artistic', 'Individual', 'Indoor', TRUE),
('Hockey', 'Field Game', 'Team', 'Outdoor', TRUE),
('Tennis', 'Racket Sport', 'Individual', 'Outdoor', TRUE),
('Table Tennis', 'Racket Sport', 'Individual', 'Indoor', TRUE),
('Badminton', 'Racket Sport', 'Individual', 'Indoor', TRUE),
('Wrestling', 'Combat Sport', 'Individual', 'Indoor', FALSE),
('Cycling', 'Endurance', 'Individual', 'Outdoor', TRUE),
('Boxing', 'Combat Sport', 'Individual', 'Indoor', FALSE);

-- Insert records into `team`
INSERT INTO team (team_name, coach_name, no_of_players, establishment_year, country_id, sport_id) VALUES
('Lakers', 'Frank Vogel', 12, 1946, 1, 1),
('Maple Leafs', 'Sheldon Keefe', 22, 1917, 2, 6),
('Blues', 'Michael Malone', 11, 1974, 5, 1),
('Samba Stars', 'Tite', 23, 1914, 9, 2),
('Tokyo United', 'Hajime Moriyasu', 23, 2000, 4, 2),
('Warriors', 'Steve Kerr', 12, 1946, 1, 1),
('Aussie Swimmers', 'Leigh Nugent', 10, 1988, 6, 3),
('Berlin Runners', 'Hans Meier', 10, 1975, 5, 4),
('Cape Blitz', 'John Trew', 15, 2001, 10, 6),
('Mumbai Smashers', 'Pullela Gopichand', 12, 2010, 7, 9),
('Paris Cyclists', 'Louis Blanc', 8, 1998, 11, 11),
('Rome Fighters', 'Marco Rossi', 12, 1985, 12, 12);

-- Insert records into `athlete`
INSERT INTO athlete (first_name, last_name, date_of_birth, gender, height, weight, country_id, sport_id) VALUES
('LeBron', 'James', '1984-12-30', 'Male', 2.03, 113.4, 1, 1),
('Megan', 'Rapinoe', '1985-07-05', 'Female', 1.68, 57.0, 1, 2),
('Sun', 'Yang', '1991-12-01', 'Male', 1.98, 89.8, 3, 3),
('Usain', 'Bolt', '1986-08-21', 'Male', 1.95, 94.0, 8, 4),
('Simone', 'Biles', '1997-03-14', 'Female', 1.42, 47.0, 1, 5),
('Roger', 'Federer', '1981-08-08', 'Male', 1.85, 85.0, 5, 7),
('PV', 'Sindhu', '1995-07-05', 'Female', 1.79, 65.0, 7, 9),
('Michael', 'Phelps', '1985-06-30', 'Male', 1.93, 88.0, 1, 3),
('Chris', 'Froome', '1985-05-20', 'Male', 1.86, 71.0, 11, 11),
('Nicola', 'Adams', '1982-10-26', 'Female', 1.64, 51.0, 12, 12);

-- Insert records into `record`
INSERT INTO record (type, value, date_achieved, sport_id) VALUES
('WR', '9.58s', '2009-08-16', 4),
('OR', '19.19s', '2012-08-12', 4),
('WR', '2:03:59', '2019-09-29', 11),
('WR', '50.58s', '2016-08-12', 3),
('OR', '3:29.65', '2021-07-24', 3),
('WR', '10.49s', '1988-07-16', 4),
('OR', '4:01.73', '2017-06-30', 11),
('WR', '15:20.85', '2020-09-10', 3),
('OR', '8.90m', '1968-10-18', 4),
('WR', '49.38s', '1984-08-06', 3);

-- Insert records into `olympic_event`
INSERT INTO olympic_event (event_name, event_year, edition, season, start_date, end_date, city_id) VALUES
('Summer Olympics 2020', 2020, 'XXXII', 'Summer', '2021-07-23', '2021-08-08', 2),
('Winter Olympics 2022', 2022, 'XXIV', 'Winter', '2022-02-04', '2022-02-20', 5),
('Summer Olympics 2016', 2016, 'XXXI', 'Summer', '2016-08-05', '2016-08-21', 9),
('Summer Olympics 2008', 2008, 'XXIX', 'Summer', '2008-08-08', '2008-08-24', 3),
('Winter Olympics 2018', 2018, 'XXIII', 'Winter', '2018-02-09', '2018-02-25', 8);

-- Insert into `olympic_event_sport`
INSERT INTO olympic_event_sport (olympic_event_id, sport_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4),
(2, 6), (2, 7),
(3, 1), (3, 3), (3, 4), (4, 5), (5, 11);

-- Insert records into `medal`
INSERT INTO medal (type) VALUES
('Gold'), ('Silver'), ('Bronze');

-- Insert into `broadcasted_`
INSERT INTO broadcasted_ (broadcaster_id, olympic_event_id, country_id, viewership) VALUES
(1, 1, 1, 50000000),
(2, 1, 2, 3000000),
(3, 1, 3, 70000000),
(4, 2, 4, 4000000),
(5, 3, 5, 1500000),
(6, 3, 6, 20000000),
(7, 4, 7, 80000000),
(8, 5, 8, 900000),
(9, 1, 9, 12000000);

-- Insert into `athlete_win_history`
INSERT INTO athlete_win_history (athlete_id, sport_id, medal_id, win_date) VALUES
(1, 1, 1, '2021-07-25'),
(2, 2, 2, '2021-07-26'),
(3, 3, 1, '2021-07-27'),
(4, 4, 1, '2009-08-16'),
(5, 5, 3, '2021-07-29'),
(6, 7, 1, '2012-07-28'),
(7, 9, 1, '2021-07-30'),
(8, 3, 2, '2008-08-11'),
(9, 4, 1, '2021-08-06'),
(10, 11, 1, '2020-09-10');

-- Insert into `team_win_history`
INSERT INTO team_win_history (team_id, sport_id, medal_id, win_date) VALUES
(1, 1, 1, '2021-07-24'),
(2, 6, 2, '2021-07-25'),
(3, 1, 3, '2021-07-26'),
(4, 2, 1, '2021-07-28'),
(5, 11, 3, '2020-09-10'),
(6, 7, 2, '2016-08-13'),
(7, 3, 1, '2021-07-31'),
(8, 4, 2, '2021-08-01'),
(9, 6, 1, '2021-08-02');

-- Insert into `users`
INSERT INTO users (username, password, role) VALUES
('admin_user', 'Admin@1234', 'ADMIN'),
('regular_user', 'User@1234', 'USER'),
('event_manager', 'Event@5678', 'ADMIN'),
('viewer1', 'Viewer#2021', 'USER'),
('sports_enthusiast', 'Sports123!', 'USER'),
('data_analyst', 'Data@7890', 'ADMIN'),
('player_view', 'Play@Pass22', 'USER'),
('team_admin', 'Team@1234', 'ADMIN'),
('broadcaster_user', 'Broadcast!21', 'USER'),
('moderator', 'Mod@4567', 'ADMIN');

-- Insert into `athlete_ranking`
INSERT INTO athelete_ranking (world_rank, points, ranking_date, federation, athlete_id, sport_id) VALUES
(1, 1500, '2021-12-01', 'FIBA', 1, 1),
(2, 1450, '2021-12-01', 'FIFA', 2, 2),
(3, 1400, '2021-12-01', 'FINA', 3, 3),
(4, 1380, '2021-12-01', 'IAAF', 4, 4),
(5, 1350, '2021-12-01', 'FIG', 5, 5),
(6, 1320, '2021-12-01', 'ITF', 6, 7),
(7, 1280, '2021-12-01', 'BWF', 7, 9),
(8, 1250, '2021-12-01', 'FINA', 8, 3),
(9, 1200, '2021-12-01', 'UCI', 10, 11);

-- Insert into `team_ranking`
INSERT INTO team_ranking (world_rank, points, ranking_date, federation, team_id, sport_id) VALUES
(1, 2500, '2021-12-01', 'FIBA', 1, 1),
(2, 2400, '2021-12-01', 'FIH', 2, 6),
(3, 2300, '2021-12-01', 'FINA', 7, 3),
(4, 2200, '2021-12-01', 'FIH', 2, 6),
(5, 2150, '2021-12-01', 'FIFA', 4, 2),
(6, 2100, '2021-12-01', 'UCI', 9, 11),
(7, 2050, '2021-12-01', 'FINA', 8, 3),
(8, 2000, '2021-12-01', 'IAAF', 3, 1),
(9, 1950, '2021-12-01', 'BWF', 10, 9);
