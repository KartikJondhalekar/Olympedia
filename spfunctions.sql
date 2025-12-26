USE CS5200_Project;

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


