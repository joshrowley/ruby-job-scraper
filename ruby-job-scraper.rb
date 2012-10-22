def choose_board
	job_boards = {
		:stack => "Careers 2.0 by stackoverflow"
	}

	puts "What job board do you want to search? (Type list to see options)"
	selection = gets.strip
	case selection
	when "list"
		job_boards.each do |key, value|
			puts "#{key} : #{value}"
		end
		choose_board
	when "stack"
		require_relative 'stackoverflow.rb'
	end
end


puts "Welcome to the Ruby Job Scraper"
puts "In what city are you looking for a Ruby job?"
@city = gets.strip
puts "How far (in miles) do you want to look?"
@distance = gets.strip.to_i
choose_board

