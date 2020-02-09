# Provided, don't edit
require 'directors_database'
require 'pp'


# A method we're giving you. This "flattens"  Arrays of Arrays so: [[1,2],
# [3,4,5], [6]] => [1,2,3,4,5,6].

def flatten_a_o_a(aoa)
  result = []
  i = 0

  while i < aoa.length do
    k = 0
    while k < aoa[i].length do
      result << aoa[i][k]
      k += 1
    end
    i += 1
  end

  result
end

def movie_with_director_name(director_name, movie_data)
  { 
    :title => movie_data[:title],
    :worldwide_gross => movie_data[:worldwide_gross],
    :release_year => movie_data[:release_year],
    :studio => movie_data[:studio],
    :director_name => director_name
  }
end


# Your code after this point

def movies_with_director_key(name, movies_collection)
  # GOAL: For each Hash in an Array (movies_collection), provide a collection
  # of movies and a directors name to the movie_with_director_name method
  # and accumulate the returned Array of movies into a new Array that's
  # returned by this method.
  #
  # INPUT:
  # * name: A director's name
  # * movies_collection: An Array of Hashes where each Hash represents a movie
  #
  # RETURN:
  #
  # Array of Hashes where each Hash represents a movie; however, they should all have a
  # :director_name key. This addition can be done by using the provided
  # movie_with_director_name method
  
  array = []
  
  
  # pp name
  # pp movies_collection
  
  i = 0
  while i < movies_collection.length
    array[i] = movie_with_director_name(name, movies_collection[i])
    i += 1
  end

  array
end


def gross_per_studio(collection)
  # GOAL: Given an Array of Hashes where each Hash represents a movie,
  # return a Hash that includes the total worldwide_gross of all the movies from
  # each studio.
  #
  # INPUT:
  # * collection: Array of Hashes where each Hash where each Hash represents a movie
  #
  # RETURN:
  #
  # Hash whose keys are the studio names and whose values are the sum
  # total of all the worldwide_gross numbers for every movie in the input Hash
  
  # pp collection[0][:movie]
  # pp collection[i][:movie][i][:worldwide_gross]  # money made by a movie
  
  # pp collection[i][:movie][i][:studio] # a movie's studio
  
  
  # get all studio names first into an array
  # eliminate copies of studios or check for copies while being made
  # using the studioNames array, create a hash in which all the keys are the studio names
  # loop through collection to take the gross and add it to its corresponding studio name
  
  hash = {}
  studioNames = []
  
  i = 0
  # pp collection
# now that the BIG MISTAKE has been fixed, this nested loop is one nest too deep (i think)
  while i < collection.length # scanning the length of the big array
  
      y = 0
      
      studioInArray = false
      
      while y < studioNames.length # scanning the new array to check for doubles before adding a studion name to it
      
        if collection[i][:movie][:studio] == studioNames[y]
          studioInArray = true
          break
        end
        y += 1
      end

      if studioInArray == false
        
        studioNames.push(collection[i][:movie][:studio])
        hash[collection[i][:movie][:studio]] = collection[i][:movie][:worldwide_gross]
        
      else
        hash[collection[i][:movie][:studio]] += collection[i][:movie][:worldwide_gross]
      end
      
    i += 1
  end

 # pp studioNames
 
 hash 
  
end

def movies_with_directors_set(source)
  # GOAL: For each director, find their :movies Array and stick it in a new Array
  #
  # INPUT:
  # * source: An Array of Hashes containing director information including
  # :name and :movies
  #
  # RETURN:
  #
  # Array of Arrays containing all of a director's movies. Each movie will need
  # to have a :director_name key added to it.
  
  
  # Return an array of arrays. Each array will contain a hash for each of a director's movies
  # Each of these hases will have a :movie tag for the movie and a :director_name tag
  # for the director
  
  # pp source 
  
  # pp source[0][:name]
  # pp source[0][:movies][0]
  
  newArray = []
  x = 0
  while x < source.length
    i = 0
    movieArray = []
    while i < source[x][:movies].length
      movieArray[i] = {:movie => source[x][:movies][i], :director_name => source[x][:name]} # Huge mistake here was that I didn't add [i] after [:movies], so it kept adding all the director's movies for each array index instead of one of his movies for each array index. The test in this lesson did not cover for duplicates and just tested for the correct director name (?) and nothing else, so mine appeared correct but really wasn't and led to flawed results in the final methods. 
      i += 1
    end
    newArray[x] = movieArray
    x += 1
  end
  newArray
end

# ----------------    End of Your Code Region --------------------
# Don't edit the following code! Make the methods above work with this method
# call code. You'll have to "see-saw" to get this to work!

def studios_totals(nds)
  a_o_a_movies_with_director_names = movies_with_directors_set(nds)
  movies_with_director_names = flatten_a_o_a(a_o_a_movies_with_director_names)
  return gross_per_studio(movies_with_director_names)
end
