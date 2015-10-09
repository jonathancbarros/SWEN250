-- Jonathan Correia de Barros
-- Oct 9 2015
-- SQL Query for the Baseball-2 assignment

.echo off
.headers off
SELECT '' ;
SELECT '' ;
SELECT '**** Standard questions ****' ;
SELECT '10 at 5 points each for 50 points' ;
SELECT '' ;
SELECT '' ; SELECT 'Query 1';
.headers on

-- Query 1
-- Print the player name, player number, and player team
-- for all catchers (position 2)

SELECT name, number, team FROM Player WHERE position = 2 ;

.headers off
SELECT '' ; SELECT 'Query 2' ;
.headers on

-- Query 2
-- Print the coach name and team name for all the managers (a type of coach).

SELECT Coach.name,Team.name
FROM Coach
INNER JOIN Team
ON Coach.team = Team.name 
WHERE title = 'Manager';

.headers off
SELECT '' ; SELECT 'Query 3' ;
.headers on

-- Query 3
-- Print the player name, number, and position (as a title) for all
-- outfielders (positions 7-9) whose home field is 'Fenway Park'.

SELECT Player.name, Player.number, Position.title
FROM Player
INNER JOIN Position
ON Player.position = Position.posnum
INNER JOIN Team
ON Player.team = Team.name
WHERE (Player.position BETWEEN 7 AND 9) AND Team.ballpark = 'Fenway Park'
;

.headers off
SELECT '' ; SELECT 'Query 4' ;
.headers on

-- Query 4
-- Print the names and numbers of the hitting coaches for 'Hanley Ramirez'.
-- There may be more than one; any coach with a title containing 'Hitting'
-- anywhere within it is a hitting coach.

SELECT Coach.name, Coach.number
FROM Coach
WHERE Coach.title LIKE '%Hitting%' AND Coach.team = 
(SELECT team FROM Player WHERE name = 'Hanley Ramirez')  
;

.headers off
SELECT '' ; SELECT 'Query 5' ;
.headers on

-- Query 5
-- Print the player name, pitching coach name, and team name for
-- all pitchers (position 1) who are over 30 years old.
-- Pitching coaches have 'Pitching' somewhere in their title.

SELECT Player.name, Coach.name, Team.name
FROM Player
INNER JOIN Team
ON Player.team = Team.name
INNER JOIN Coach
ON Player.team = Coach.team
WHERE Player.position = 1 AND Player.age > 30 AND Coach.title LIKE '%Pitching%'
;

.headers off
SELECT '' ; SELECT 'Query 6' ;
.headers on

-- Query 6
-- Print the names, numbers, and ages of all infielders (positions 3-6)
-- whose home field is 'Camden Yards'.

SELECT Player.name, Player.number, Player.age
FROM Player
WHERE (Player.position BETWEEN 3 AND 6) AND 
Player.team = (SELECT name FROM Team WHERE ballpark = 'Camden Yards')
;

.headers off
SELECT '' ; SELECT 'Query 7' ;
.headers on

-- Query 7
-- Print the names, numbers, and team of all outfielders (positions 7-9)
-- whose manager's first name is 'John'


SELECT Player.name, Player.number, Player.team
FROM Player
WHERE Player.team IN 
(SELECT team FROM Coach WHERE name LIKE 'John%' AND title = 'Manager') AND 
Player.position BETWEEN 7 AND 9
ORDER BY Player.team DESC
;

.headers off
SELECT '' ; SELECT 'Query 8' ;
.headers on

-- Query 8
-- Print the names of the bullpen coaches for teams on the Eastern Seaboard
-- (Boston, Baltimore, and New York).

SELECT name
FROM Coach
WHERE title = 'Bullpen Coach'
AND
team IN (SELECT name FROM Team WHERE city IN ('Boston','Baltimore','New York'))
;

.headers off
SELECT '' ; SELECT 'Query 9' ;
.headers on

-- Query 9
-- Print the name, position, number, and team of all players whose
-- position is greater than their (jersey) number.

SELECT name, position, number, team
FROM Player
WHERE position > number ;

.headers off
SELECT '' ; SELECT 'Query 10' ;
.headers on

-- Query 10
-- Print the name and position title for all players whose (first) name
-- begins with 'D'

SELECT name, Position.title
FROM Player
INNER JOIN Position
ON Player.position = Position.posnum
WHERE name LIKE 'D%'; 

.headers off
SELECT '' ;
SELECT '' ;
SELECT '**** Extra credit ****'  ;
SELECT '5 at 2 points each for 10 bonus points max.' ;
SELECT '' ;
SELECT '' ; SELECT 'Extra Credit 1' ;
.headers on

-- Query EC1
-- Create a listing of all player names and numbers for players on the 'Rays'
-- sorted by ascending name.
-- See ORDER BY

SELECT name, number
FROM Player
WHERE team = 'Rays'
ORDER BY name ASC
;

.headers off
SELECT '' ; SELECT 'Extra Credit 2' ;

-- Query EC2
-- How many infielders (positions 3-6) are in the database?
-- See the count() function.

SELECT COUNT (name)
FROM Player
WHERE position BETWEEN 3 AND 6
;

SELECT '' ; SELECT 'Extra Credit 3' ;

-- Query EC3
-- What is the average age of all pitchers (position 1) in the database (rounded to
-- two fractional digit)?
-- See the avg() and round() functions.

SELECT ROUND ( AVG(age), 2)
FROM Player
WHERE position = 1
;

SELECT '' ; SELECT 'Extra Credit 4' ;

-- Query EC4
-- How many infielders (positions 3-6) are there in the database *by team*?
-- Each output line has a count and a team name.
-- See GROUP BY

SELECT COUNT(name), team
FROM Player
WHERE position BETWEEN 3 AND 6
GROUP BY team
;

SELECT '' ; SELECT 'Extra Credit 5' ;

-- Query EC5
-- What is the average age of all pitchers (position 1) in the database *by team*?
-- Each output line has an average age rounded to two fractional digits and a team name.
-- The lines should be ordered by increasing average age.
-- See GROUP BY

SELECT ROUND(AVG(age),2) AS AgeAverage, team
FROM Player
WHERE position = 1
GROUP BY team
ORDER BY AgeAverage ASC
;
