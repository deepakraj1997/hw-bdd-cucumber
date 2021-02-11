# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  	@movie = Movie.create(movie)
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
	page.body.index(e1) < page.body.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
	filtered_ratings = rating_list == "all" ? Movie.all_ratings : rating_list.split(" ")

  	filtered_ratings.each do |rating|
    		if uncheck == "un"
     			steps %Q{Given I am on \"ratings_#{rating}\"}
    		else
      			steps %Q{Given I am on \"ratings_#{rating}\"}
    		end
  	end
end

When /I should see the movies rated: (.*)/ do |rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb

  filtered_ratings = rating_list == "all" ? Movie.all_ratings : rating_list.split(" ")

  @movies.each do |movie|
    if rating_list_array.include?(movie.rating)
      page.body.include?(movie.title) == true
    else
      page.body.include?(movie.title) == false
    end

end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
	@movies = Movie.all
  	@movies.each do |movie|
      		page.body.include?(movie.title).should == true
  	end	
end
