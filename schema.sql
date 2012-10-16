require 'sqlite3'

db = SQLite3::Database.new("jobs.db")

sql = <<SQL
CREATE table students 
(	id INTEGER PRIMARY KEY,
	title TEXT,
	employer TEXT,
	employer_link TEXT,
	location TEXT,
	description TEXT,
	skills TEXT,
	about_employer TEXT
	);
SQL