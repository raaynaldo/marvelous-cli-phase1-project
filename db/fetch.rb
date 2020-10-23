require "pry"
require "rest-client"
require "json"
# require_relative "./app/models/"

def character_hashes
  hero_ids = [1009610, 1009187, 1009220, 1009718, 1009515, 1009368, 1009351, 1010338, 1009268, 1009262]

  character_hashes = []
  hero_ids.each { |id|
    character_response_string = RestClient.get("http://gateway.marvel.com/v1/public/characters/#{id}?ts=thesoer&apikey=blank&hash=blank")
    response_hash = JSON.parse(character_response_string)
    character_hashes << response_hash["data"]["results"][0]
  }

  character_hashes
end

def characters_table
  binding.pry
  characters = character_hashes().map { |character|
    {
      :id => character["id"],
      :name => character["name"],
    }
  }
  characters
end

def comics_table
  comics = []
  character_hashes().each { |character|
    comics += character["comics"]["items"].take(10).map { |comic|
      uri = comic["resourceURI"].split("/")
      uri.pop
    }
  }

  # comic_hashes = []
  # comics.each { |id|
  #   comics_response_string = RestClient.get("http://gateway.marvel.com/v1/public/comics/#{id}?ts=thesoer&apikey=ddf1f8c719c55c1f89f29b150b774ab0&hash=7ac330aa3ce2bc03b6c1f5d0f50ecdfa")
  #   response_hash = JSON.parse(comics_response_string)
  #   comic_hashes << response_hash["data"]["results"][0]
  # }
  # comics = comic_hashes.map { |comic|
  #   {
  #     :id => comic["id"],
  #     :name => comic["title"],
  #     :price => comic["prices"][0]["price"],
  #   }
  # }

  comics
end

def character_comics_table
  # ray
  # get the character_comics data from API
  # insert to the database using active record
  #Use character_hashes and comics_table methods with in here?
  #Doing the activerecord again seems redundent since done in those two methods
  #Also character_comic has already been reasigned its ID's below
  #using respone_hash works as parameter above but wont work when I call method on its own in line 85
  #perhapes i need to use both comics_table and character_table as perameters for character_comics_table No
  #i need to somehow call the other two method within here more specificly the RestClient and JSON.parse
  # character_comic = []
  # binding.pry
  # response_hash["data"]["results"].each { |character|
  #   character["comics"]["items"].each { |comic|
  #     character_comic << {
  #       :character_id => character["id"],
  #       :comic_id => comic["id"],
  #     }
  #     binding.pry
  #   }
  # }

  character_comics = []
  character_hashes().each { |character|
    character["comics"]["items"].take(10).each { |comic|
      character_comics << {
        :character_id => character["id"],
        :comis_id => comic["resourceURI"].split("/").pop,
      }
    }
  }
  character_comics
end

puts characters_table()
# puts comics_table()
# binding.pry
