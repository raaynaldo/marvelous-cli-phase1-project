require "pry"

class User < ActiveRecord::Base
  has_many :favorite_characters
  has_many :characters, through: :favorite_characters

  def favorite_character
    self.characters.pluck(:name)
  end

  def add_favorite_character(hero)
    char = Character.find_by(name: hero)
    FavoriteCharacter.create(user: self, character: char)
  end

  def comic_reccomendations
    comics = []
    self.characters.each { |character| 
        comics += character.comics.map { |comic| comic.name } }
    comics.uniq
  end
end
