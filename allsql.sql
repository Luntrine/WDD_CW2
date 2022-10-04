CREATE DATABASE travelAdvisor

CREATE TABLE countries (
    countryID int NOT NULL AUTO_INCREMENT,
    countryName varchar(255),
    currency varchar(255),
    visaRequiredFromUK SET('Yes', 'Not required'),
    PRIMARY KEY (countryID)
);

CREATE TABLE cities (
    cityID int NOT NULL AUTO_INCREMENT,
    cityName varchar(255),
    countryID int,
    PRIMARY KEY (cityID),
    FOREIGN KEY (countryID) REFERENCES countries(countryID)
);

CREATE TABLE sites (
    siteID int NOT NULL AUTO_INCREMENT,
    siteName varchar(255),
    category SET('Museum', 'Park', 'Ride', 'Architecture', 'Food and Drink'),
    cityID int,
    PRIMARY KEY (siteID),
    FOREIGN KEY (cityID) REFERENCES cities(CityID)
);

CREATE TABLE users (
    userID int NOT NULL AUTO_INCREMENT,
    name varchar(255),
    email varchar(255),
    hasVisa SET('Yes', 'No')
    PRIMARY KEY (userID)
);

CREATE TABLE uservisits (
    ratingID int NOT NULL AUTO_INCREMENT,
    userID int,
    siteID int,
    rating int CHECK (rating>=1 AND rating<=5),
    PRIMARY KEY (ratingID),
    FOREIGN KEY (userID) REFERENCES users(userID),
    FOREIGN KEY (siteID) REFERENCES sites(siteID)
);


INSERT INTO countries (countryName, currency, visaRequiredFromUK)
VALUES ('United Kingdom', 'Great British Pound', 'Not requred'), ('America', 'US Dollar', 'Yes'), ('France', 'Euro', 'Not requred'), ('Canada', 'Canadian Dollar', 'Not requred'), ('Australia', 'Austrailian Dollar', 'Yes');

INSERT INTO cities (cityName, countryID)
VALUES ('London', 1), ('Edinburgh', 1), ('New York', 2), ('Washington DC', 2), ('Paris', 3), ('Lyon', 3), ('Toronto', 4), ('Montreal', 4), ('Sydney', 5), ('Melbourne', 5);

INSERT INTO sites (siteName, category, cityID)
VALUES ('London Eye', 'Ride', 1), ('Hyde Park', 'Park', 1), ('Edinburgh Castle', 'Architecture', 2), ('National Museum of Scotland', 'Museum', 2), ('Central Park', 'Park', 3), ('Statue of Liberty', 'Architecture', 3), ('White House', 'Architecture', 4), ('Smithsonian National Museum of Natural History', 'Museum', 4), ('Jules Verne Restaurant - Eiffel Tower', 'Food and Drink', 5), ('Arc de Triomphe', 'Architecture', 5), ('Museum of Fine Arts Lyon', 'Museum', 6), ('Vieux Lyon', 'Architecture', 6), ('CN Tower', 'Architecture', 7), ('Casa Loma', 'Architecture', 7), ('Jean Talon Market', 'Food and Drink', 8), ('Montral Botanical Garden', 'Park', 8), ('Sydney Opera House', 'Architecture', 9), ('Marrickville Organic Food and Farmers Market', 'Food and Drink', 9), ('City Circle Tram', 'Ride', 10), ('Shrine of Remembrance', 'Architecture', 10);

INSERT INTO users (name, email, hasVisa)
VALUES ('Matthew Forsyth', 'mgf2001@hw.ac.uk', 'No'),  ('CJ Pell', 'cp2020@hw.ac.uk', 'No'), ('Lucca Marcondes Browning', 'lam2002@hw.ac.uk', 'Yes'), ('Jamie Mcintosh', 'jm2055@hw.ac.uk', 'Yes'), ('James Stewart', 'jws2000@hw.ac.uk', 'Yes');

INSERT INTO uservisits (userID, siteID, rating)
VALUES (1,1,1), (1,2,1), (1,3,1), (1,4,1), (2,5,2), (2,6,2), (2,7,2), (2,8,2), (3,9,3), (3,10,3), (3,11,3), (3,12,3), (4,13,4), (4,14,4), (4,15,4), (4,16,4), (5,17,5), (5,18,5), (5,19,5), (5,20,5);


SELECT cityName
FROM cities, sites
WHERE (sites.category = "Museum") AND (sites.cityID = cities.cityID);

SELECT cities.cityName
FROM countries 
INNER JOIN cities ON (cities.countryID = countries.countryID) 
WHERE (countries.visaRequiredFromUK != "Yes");

SELECT cityName 
FROM cities, countries 
WHERE (countries.visaRequiredFromUK != "Yes") and (cities.countryID = countries.countryID);

SELECT users.name
FROM users
INNER JOIN uservisits ON (uservisits.userID = users.userID)
INNER JOIN sites ON (sites.siteID = uservisits.siteID)
WHERE sites.siteName = "Central Park";

SELECT cities.cityName
FROM cities
INNER JOIN sites ON (sites.cityID = cities.cityID)
WHERE sites.category = "Museum";

SELECT users.name
FROM users
INNER JOIN uservisits ON (uservisits.userID = users.userID)
INNER JOIN sites ON (sites.siteID = uservisits.siteID)
WHERE sites.siteName = "Statue of Liberty";

SELECT users.name
FROM users
INNER JOIN uservisits ON (uservisits.userID = users.userID)
INNER JOIN sites ON (sites.siteID = uservisits.siteID)
INNER JOIN cities ON (cities.cityID = sites.cityID)
WHERE cities.cityName = "Melbourne"
GROUP BY name;

SELECT users.name
FROM users
INNER JOIN uservisits ON (uservisits.userID = users.userID)
INNER JOIN sites ON (sites.siteID = uservisits.siteID)
INNER JOIN cities ON (cities.cityID = sites.cityID)
INNER JOIN countries ON (countries.countryID = cities.countryID)
WHERE countries.countryName = "France"
GROUP BY name;

SELECT countries.countryName  
FROM countries  
INNER JOIN cities ON (cities.countryID = countries.countryID)  
INNER JOIN sites ON (sites.cityID = cities.cityID)  
WHERE sites.category = "Food and Drink";

SELECT countries.countryName 
FROM countries 
INNER JOIN cities ON (cities.countryID = countries.countryID)
INNER JOIN sites ON (sites.cityID = cities.cityID) 
WHERE (sites.category = "Architecture") and (countries.visaRequiredFromUK != "Yes");

SELECT sites.siteName
FROM users
INNER JOIN uservisits ON (uservisits.userID = users.userID)
INNER JOIN sites ON (sites.siteID = uservisits.siteID)
WHERE uservisits.rating = "5";

