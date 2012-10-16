require 'open-uri'
require 'nokogiri'
require 'sqlite3'

# Nice to have: dynamic location and distance range to create query to Stackoverflow board (i.e. this file receives 'new york' as the location and '20' as the mile range which to look at on stackoverflow)
# TODO: Create db

db = SQLite3::Database.new("jobs.db")

sql = <<SQL
CREATE table students 
(	id INTEGER PRIMARY KEY,
	title TEXT,
	employer TEXT,
	location TEXT,
	description TEXT,
	skills TEXT,
	about_employer TEXT
	);
SQL

db.execute sql

# Nice to have: Put this database creation logic in another spot



# TODO: Load main Stack Overflow into Nokogiri


# TODO: Parse out the links from the main index page to the individual jobs pages, put this into an array
#Check if there's another page
#If there is go to the link on that page and add those job links into the individual jobs array as well.


# TODO: Iterate through the array, pull out the necessary variables for the database.
#TODO: Save to the database