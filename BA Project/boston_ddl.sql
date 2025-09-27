-- Create boston crime data schema and tables
CREATE SCHEMA boston;

CREATE TABLE boston.offense (
    offense_code            VARCHAR(15),
    offense_description     VARCHAR(100), 
    PRIMARY KEY (offense_code)
);

CREATE TABLE boston.district (
    district_code       VARCHAR(15),
    district_name       VARCHAR(150), 
    PRIMARY KEY (district_code)
);

CREATE TABLE boston.location (
    location_id     VARCHAR(10),
    district_code   VARCHAR(15),
    street          VARCHAR(100),
    longitude       DOUBLE PRECISION,
    latitude        DOUBLE PRECISION,
    PRIMARY KEY (location_id),
    FOREIGN KEY (district_code) REFERENCES boston.district (district_code)
        ON DELETE SET NULL
        ON UPDATE CASCADE;
);

CREATE TABLE boston.incident (
    incident_number     VARCHAR(15),
    offense_code        VARCHAR(15),
    district_code       VARCHAR(15),
    shooting            SMALLINT, 
    occurred_on_date    TIMESTAMP WITH TIME ZONE,
    year                INTEGER,
    month               SMALLINT,
    day_of_week         VARCHAR(15),
    hour                SMALLINT,
    location_id VARCHAR(10),
    PRIMARY KEY (incident_number),
    FOREIGN KEY (offence_code) REFERENCES boston.offense (offence_code)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (district_code) REFERENCES boston.district (district_code)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (location_id) REFERENCES boston.location (location_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
