# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
Studio.destroy_all
Movie.destroy_all
Actor.destroy_all
Role.destroy_all

# Generate models and tables, according to the domain model.
#rails generate model Studio
#rails generate model Movie
#rails generate model Actor
#rails generate model Role

# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.
new_studio = Studio.new
new_studio["name"] = "Warner Bros."
new_studio.save

new_movie = Movie.new
new_movie["title"] = "Batman Begins"
new_movie["year_released"] = 2005
new_movie["rated"] = "PG-13"
new_movie["studio_id"] = Studio.find_by({"name"=>"Warner Bros."})["id"]
new_movie.save

new_movie = Movie.new
new_movie["title"] = "The Dark Knight"
new_movie["year_released"] = 2008
new_movie["rated"] = "PG-13"
new_movie["studio_id"] = Studio.find_by({"name"=>"Warner Bros."})["id"]
new_movie.save

new_movie = Movie.new
new_movie["title"] = "The Dark Knight Rises"
new_movie["year_released"] = 2012
new_movie["rated"] = "PG-13"
new_movie["studio_id"] = Studio.find_by({"name"=>"Warner Bros."})["id"]
new_movie.save

actors = ["Christian Bale","Michael Caine","Liam Neeson","Katie Holmes","Gary Oldman", 
"Heath Ledger", "Aaron Eckhart","Maggie Gyllenhaal", "Tom Hardy","Joseph Gordon-Levitt",
"Anne Hathaway"]
for actor in actors
    new_actor = Actor.new
    new_actor["name"] = actor
    new_actor.save
end

actors_movie1 = ["Christian Bale","Michael Caine","Liam Neeson","Katie Holmes","Gary Oldman"]
roles_movie1 = ["Bruce Wayne","Alfred","Ra's Al Ghul","Rachel Dawes","Commissioner Gordon"]

for i in 0..roles_movie1.size - 1
    role_movie1 = Role.new
    role_movie1["movie_id"] = Movie.find_by({"title"=>"Batman Begins"})["id"]
    role_movie1["actor_id"] = Actor.find_by({"name"=>actors_movie1[i]})["id"]
    role_movie1["character_name"] = roles_movie1[i]
    role_movie1.save
end

actors_movie2 = ["Christian Bale","Heath Ledger", "Aaron Eckhart","Michael Caine","Maggie Gyllenhaal"]
roles_movie2 = ["Bruce Wayne","Joker","Harvey Dent","Alfred","Rachel Dawes"]

for i in 0..roles_movie2.size - 1
    role_movie2 = Role.new
    role_movie2["movie_id"] = Movie.find_by({"title"=>"The Dark Knight"})["id"]
    role_movie2["actor_id"] = Actor.find_by({"name"=>actors_movie2[i]})["id"]
    role_movie2["character_name"] = roles_movie2[i]
    role_movie2.save
end

actors_movie3 = ["Christian Bale","Gary Oldman","Tom Hardy","Joseph Gordon-Levitt","Anne Hathaway"]
roles_movie3 = ["Bruce Wayne","Commissioner Gordon","Bane","John Blake","Selina Kyle"]

for i in 0..roles_movie3.size - 1
    role_movie3 = Role.new
    role_movie3["movie_id"] = Movie.find_by({"title"=>"The Dark Knight Rises"})["id"]
    role_movie3["actor_id"] = Actor.find_by({"name"=>actors_movie3[i]})["id"]
    role_movie3["character_name"] = roles_movie3[i]
    role_movie3.save
end

# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.
movies = Movie.all
for movie in movies
    studio_id = movie["studio_id"]
    studio = Studio.find_by({"id" => studio_id}).inspect
    puts "#{movie["title"]}  #{movie["year_released"]}  #{movie["rated"]}  #{studio["name"]}"
end

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
roles = Role.all
for role in roles
    movie = Movie.find_by({"id"=>role["movie_id"]}).inspect
    actor = Actor.find_by({"id"=>role["actor_id"]}).inspect
    puts "#{movie["title"]}  #{actor["name"]}  #{role["character_name"]}"
end
