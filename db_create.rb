require 'sqlite3'
require 'FileUtils'


FileUtils.rm("jobs.db") if File.exists?("jobs.db")

@db = SQLite3::Database.new "jobs.db"

sql = <<SQL
CREATE table jobs 
(	id INTEGER PRIMARY KEY,
	title TEXT,
	link TEXT,
	employer TEXT,
	employer_link TEXT,
	location TEXT,
	description TEXT,
	skills TEXT,
	about_employer TEXT
	);
SQL

@db.execute sql