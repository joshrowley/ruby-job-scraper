require 'open-uri'
require 'nokogiri'
require 'sqlite3'




require_relative 'db_create.rb'

# Nice to have: dynamic location and distance range to create query to Stackoverflow board (i.e. this file receives 'new york' as the location and '20' as the mile range which to look at on stackoverflow)

# TODO: Load main Stack Overflow into Nokogiri
# uri = "http://careers.stackoverflow.com/jobs?searchTerm=ruby&location=new+york&range=20"
# doc = Nokogiri::HTML(open(uri))


# job_links = doc.css('a.title').map do |obj|
# 	"http://careers.stackoverflow.com#{obj["href"]}"
# end
city = @city.gsub(" ", "+")
distance = @distance


job_links = []
is_there_a_next_page = true
page = 1
while is_there_a_next_page == true
	uri = "http://careers.stackoverflow.com/jobs?searchTerm=ruby&location=#{city}&range=#{distance}&pg=#{page}"
	doc = Nokogiri::HTML(open(uri))
	this_pages_links = doc.css('a.title').map do |obj|
	"http://careers.stackoverflow.com#{obj["href"]}"
	end
	job_links.concat(this_pages_links)
	page += 1

	if this_pages_links.empty?
		is_there_a_next_page = false
	end
end




# page =  2
# until page.empty?
# 	uri = "#{uri}&pg=#{page}"



# doc = Nokogiri::HTML(open(next_page_uri))
# next_page_job_links = doc.css('a.title').map do |obj|
# 	"http://careers.stackoverflow.com#{obj["href"]}"
# end

# third_page_uri = "#{uri}&pg=3"
# doc = Nokogiri::HTML(open(third_page_uri))
# third_links = doc.css('a.title').map do |obj|
# 	"http://careers.stackoverflow.com#{obj["href"]}"
# end
# if third_links.empty?
# 	puts "true"
# end

#if the previous button is on the page
# check if next button is on the page
# then grab the second prev-next class button's href in nokogiri


# parse next button
# if it exists, extract the link
# run job_links again on this new page
# check if there's another link

#NICE TO HAVE: Check if there's another page
# while next_page.exists?
# run the loop
#If there is go to the link on that page and add those job links into the individual jobs array as well.


job_links.each do |link|
	doc = Nokogiri::HTML(open(link))

	title = doc.css('a.title').text.strip
	employer = doc.css('a.employer').text.strip
	employer_link = doc.css('a.employer').first["href"]
	location = doc.css('span.location').text.strip
	description = doc.css('div.description')[0].text.strip
	skills = if doc.css('div.description')[1]
				doc.css('div.description')[1].text.strip
			else
				""
			end
	about_employer = if doc.css('div.description')[2]
						doc.css('div.description')[2].text.strip
					else
						""
					end
	

@db.execute("INSERT INTO jobs (title, link, employer, employer_link, location, description, skills, about_employer) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", title, link, employer, employer_link, location, description, skills, about_employer)

end

