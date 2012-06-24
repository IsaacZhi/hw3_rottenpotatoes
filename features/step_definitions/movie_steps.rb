# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
      Movie.create!(movie)
  end
#flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
#flunk "Unimplemented"
  page.body[/#{e1}.*#{e2}/] != nil
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  if nil == uncheck then
    rating_list.split(%r{,\s*}).each do |onerating|
      steps %Q{ When I check "ratings[#{onerating}]" }
    end
  else
    rating_list.split(%r{,\s*}).each do |onerating|
      steps %Q{ When I uncheck "ratings[#{onerating}]" }
    end
  end
end

Then /I should see all of the movies/ do
  rows = 0
  if  page.body != nil then
    movielistindex = page.body.index("movielist")
    movielistbody = (page.body)[movielistindex, page.body.length - 1]
    if movielistbody != nil then
      movielistbody.gsub(/<tr>/) { |word| rows += 1 }
    end
  end
  rows.should == 10 
end
