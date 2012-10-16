require 'open-uri'
require 'nokogiri'
require 'sqlite3'
require 'FileUtils'

# Nice to have: dynamic location and distance range to create query to Stackoverflow board (i.e. this file receives 'new york' as the location and '20' as the mile range which to look at on stackoverflow)

FileUtils.rm("jobs.db") if File.exists?("jobs.db")

db = SQLite3::Database.new "jobs.db"

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

db.execute sql

# Nice to have: Put this database creation logic in another spot



# TODO: Load main Stack Overflow into Nokogiri
uri = "http://careers.stackoverflow.com/jobs?searchTerm=ruby&location=new+york&range=20"


doc = Nokogiri::HTML(open(uri))
job_links = doc.css('a.title').map do |obj|
	"http://careers.stackoverflow.com#{obj["href"]}"
end

#NICE TO HAVE: Check if there's another page
# while next_page.exists?
# run the loop
#If there is go to the link on that page and add those job links into the individual jobs array as well.


# TODO: Iterate through the array, pull out the necessary variables for the database.

job_links.each do |link|
	doc = Nokogiri::HTML(open(link))

	title = doc.css('a.title').text.strip
	employer = doc.css('a.employer').text.strip
	employer_link = doc.css('a.employer').first["href"]
	puts employer_link





#TODO: Save to the database

end

