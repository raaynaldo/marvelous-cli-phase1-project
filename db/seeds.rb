require "pry"
require "rest-client"
require "json"

# get 10 array of hash characters from the API
hero_ids = [1009610, 1009187, 1009220, 1009718, 1009515, 1009368, 1009351, 1010338, 1009268, 1009262]
response_hash = []
hero_ids.each { |id|
  character_response_string = RestClient.get("http://gateway.marvel.com/v1/public/characters/#{id}?ts=thesoer&apikey=blank&hash=blank")
  response_string = JSON.parse(character_response_string)
  response_hash << response_string["data"]["results"][0]
}


# Fetch Characters from API
characters_hashes = response_hash.map { |character|
  {
    :id => character["id"],
    :name => character["name"],
  }
}
# Insert Characters data from API to the table
characters_hashes.each { |character|
  Character.find_or_create_by(id: character[:id], name: character[:name])
}


# Fetch Comics from API
comics_hashes = []
response_hash.each { |character|
  comics_hashes += character["comics"]["items"].take(10).map { |comic|
    {
      :id => comic["resourceURI"].split("/").pop,
      :name => comic["name"],
    }
  }
}
# Insert Comics data from API to the table
comics_hashes.uniq.each { |comic|
  Comic.find_or_create_by(id: comic[:id], name: comic[:name], price: rand(5..15))
}


# Fetch Character_Comics from API
character_comic_hashes = []
response_hash.each { |character|
  character["comics"]["items"].take(10).each { |comic|
    character_comic_hashes << {
      :character_id => character["id"],
      :comic_id => comic["resourceURI"].split("/").pop,
    }
  }
}
# Insert Character_Comics data from API to the table
character_comic_hashes.each { |character_comic|
  CharacterComic.find_or_create_by(character_id: character_comic[:character_id], comic_id: character_comic[:comic_id])
}

erick = User.find_or_create_by(name: "Erick")
FavoriteCharacter.find_or_create_by(user_id: erick.id, character_id: 1009187)
FavoriteCharacter.find_or_create_by(user_id: erick.id, character_id: 1009187)
FavoriteCharacter.find_or_create_by(user_id: erick.id, character_id: 1009515)

ray = User.find_or_create_by(name: "Raynaldo")
FavoriteCharacter.find_or_create_by(user_id: ray.id, character_id: 1010338)
FavoriteCharacter.find_or_create_by(user_id: ray.id, character_id: 1009220)
FavoriteCharacter.find_or_create_by(user_id: ray.id, character_id: 1009351)
FavoriteCharacter.find_or_create_by(user_id: ray.id, character_id: 1009610)

vita = User.find_or_create_by(name: "Vita")
FavoriteCharacter.find_or_create_by(user_id: vita.id, character_id: 1009718)
FavoriteCharacter.find_or_create_by(user_id: vita.id, character_id: 1009368)

rico = User.find_or_create_by(name: "Rico")
FavoriteCharacter.find_or_create_by(user_id: rico.id, character_id: 1009187)

aaron = User.find_or_create_by(name: "Aaron")
FavoriteCharacter.find_or_create_by(user_id: aaron.id, character_id: 1009268)
FavoriteCharacter.find_or_create_by(user_id: aaron.id, character_id: 1009262)
FavoriteCharacter.find_or_create_by(user_id: aaron.id, character_id: 1009610)
FavoriteCharacter.find_or_create_by(user_id: aaron.id, character_id: 1010338)

monica = User.find_or_create_by(name: "Monica")
FavoriteCharacter.find_or_create_by(user_id: monica.id, character_id: 1009515)


rolando = User.find_or_create_by(name: "Rolando")
FavoriteCharacter.find_or_create_by(user_id: rolando.id, character_id: 1009187)
FavoriteCharacter.find_or_create_by(user_id: rolando.id, character_id: 1009515)

jake = User.find_or_create_by(name: "Jake From StateFarm")
FavoriteCharacter.find_or_create_by(user_id: jake.id, character_id: 1009515)
FavoriteCharacter.find_or_create_by(user_id: jake.id, character_id: 1009268)

jason = User.find_or_create_by(name: "Jason")
FavoriteCharacter.find_or_create_by(user_id: jason.id, character_id: 1009187)
FavoriteCharacter.find_or_create_by(user_id: jason.id, character_id: 1009220)
FavoriteCharacter.find_or_create_by(user_id: jason.id, character_id: 1009262)
FavoriteCharacter.find_or_create_by(user_id: jason.id, character_id: 1009268)
FavoriteCharacter.find_or_create_by(user_id: jason.id, character_id: 1009351)
FavoriteCharacter.find_or_create_by(user_id: jason.id, character_id: 1009368)
FavoriteCharacter.find_or_create_by(user_id: jason.id, character_id: 1009515)
FavoriteCharacter.find_or_create_by(user_id: jason.id, character_id: 1009610)
FavoriteCharacter.find_or_create_by(user_id: jason.id, character_id: 1009718)
FavoriteCharacter.find_or_create_by(user_id: jason.id, character_id: 1010338)

# 1009187 Black Panther
# 1009220 Captain America
# 1009262 Daredevil
# 1009268 Deadpool
# 1009351 Hulk
# 1009368 Iron Man
# 1009515 Punisher
# 1009610 Spider-Man
# 1009718 Wolverine
# 1010338 Captain Marvel (Carol Danvers)

# spiderman = Character.find_or_create_by(name: "Spider-Man")
# wolverine = Character.find_or_create_by(name: "Wolverine")
# iron_man = Character.find_or_create_by(name: "Iron Man")
# hulk = Character.find_or_create_by(name: "Hulk")
# black_panther = Character.find_or_create_by(name: "Black Panther")
# antman = Character.find_or_create_by(name: "Ant Man")

# FavoriteCharacter.find_or_create_by(user_id: ray.id, character_id: spiderman.id)
# FavoriteCharacter.find_or_create_by(user_id: ray.id, character_id: hulk.id)

# FavoriteCharacter.find_or_create_by(user_id: rolando.id, character_id: iron_man.id)
# FavoriteCharacter.find_or_create_by(user_id: rolando.id, character_id: hulk.id)

# FavoriteCharacter.find_or_create_by(user_id: monica.id, character_id: iron_man.id)
# FavoriteCharacter.find_or_create_by(user_id: monica.id, character_id: spiderman.id)

# FavoriteCharacter.find_or_create_by(user_id: erick.id, character_id: wolverine.id)
# FavoriteCharacter.find_or_create_by(user_id: erick.id, character_id: black_panther.id)

# FavoriteCharacter.find_or_create_by(user_id: vita.id, character_id: wolverine.id)
# FavoriteCharacter.find_or_create_by(user_id: vita.id, character_id: black_panther.id)
# FavoriteCharacter.find_or_create_by(user_id: vita.id, character_id: iron_man.id)

# FavoriteCharacter.find_or_create_by(user_id: rico.id, character_id: wolverine.id)
# FavoriteCharacter.find_or_create_by(user_id: rico.id, character_id: iron_man.id)

# spiderman_comic_1 = Comic.find_or_create_by(name: "Spiderman Comic vol 1", price: 10)
# spiderman_comic_2 = Comic.find_or_create_by(name: "Spiderman Comic vol 2", price: 10)
# spiderman_comic_3 = Comic.find_or_create_by(name: "Spiderman Comic vol 3", price: 10)
# spiderman_comic_4 = Comic.find_or_create_by(name: "Spiderman Comic vol 4", price: 10)

# wolverine_comic_1 = Comic.find_or_create_by(name: "Wolverine Comic vol 1", price: 9)
# wolverine_comic_2 = Comic.find_or_create_by(name: "Wolverine Comic vol 2", price: 9)
# wolverine_comic_3 = Comic.find_or_create_by(name: "Wolverine Comic vol 3", price: 9)
# wolverine_comic_4 = Comic.find_or_create_by(name: "Wolverine Comic vol 4", price: 9)

# iron_man_comic_1 = Comic.find_or_create_by(name: "Iron Man Comic vol 1", price: 8)
# iron_man_comic_2 = Comic.find_or_create_by(name: "Iron Man Comic vol 2", price: 8)
# iron_man_comic_3 = Comic.find_or_create_by(name: "Iron Man Comic vol 3", price: 8)
# iron_man_comic_4 = Comic.find_or_create_by(name: "Iron Man Comic vol 4", price: 8)

# avenger_comic_1 = Comic.find_or_create_by(name: "Avenger vol 1", price: 12)
# avenger_comic_2 = Comic.find_or_create_by(name: "Avenger vol 2", price: 12)
# avenger_comic_3 = Comic.find_or_create_by(name: "Avenger vol 3", price: 12)
# avenger_comic_4 = Comic.find_or_create_by(name: "Avenger vol 4", price: 12)

# CharacterComic.find_or_create_by(character: spiderman, comic: spiderman_comic_1)
# CharacterComic.find_or_create_by(character: spiderman, comic: spiderman_comic_2)
# CharacterComic.find_or_create_by(character: spiderman, comic: spiderman_comic_3)
# CharacterComic.find_or_create_by(character: spiderman, comic: spiderman_comic_4)

# CharacterComic.find_or_create_by(character: wolverine, comic: wolverine_comic_1)
# CharacterComic.find_or_create_by(character: wolverine, comic: wolverine_comic_2)
# CharacterComic.find_or_create_by(character: wolverine, comic: wolverine_comic_3)
# CharacterComic.find_or_create_by(character: wolverine, comic: wolverine_comic_4)

# CharacterComic.find_or_create_by(character: iron_man, comic: iron_man_comic_1)
# CharacterComic.find_or_create_by(character: iron_man, comic: iron_man_comic_2)
# CharacterComic.find_or_create_by(character: iron_man, comic: iron_man_comic_3)
# CharacterComic.find_or_create_by(character: iron_man, comic: iron_man_comic_4)

# CharacterComic.find_or_create_by(character: spiderman, comic: avenger_comic_1)
# CharacterComic.find_or_create_by(character: spiderman, comic: avenger_comic_2)
# CharacterComic.find_or_create_by(character: spiderman, comic: avenger_comic_3)

# CharacterComic.find_or_create_by(character: iron_man, comic: avenger_comic_1)
# CharacterComic.find_or_create_by(character: iron_man, comic: avenger_comic_2)
# CharacterComic.find_or_create_by(character: iron_man, comic: avenger_comic_3)

# CharacterComic.find_or_create_by(character: hulk, comic: avenger_comic_1)
# CharacterComic.find_or_create_by(character: hulk, comic: avenger_comic_2)
# CharacterComic.find_or_create_by(character: hulk, comic: avenger_comic_3)