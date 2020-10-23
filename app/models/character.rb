require "pry"

class Character < ActiveRecord::Base
  has_many :character_comics
  has_many :comics, through: :character_comics
  has_many :favorite_characters
  has_many :users, through: :favorite_characters

  def get_fans
    self.users.pluck(:name)
  end

  def self.top_char(limit)
    Character.joins("LEFT JOIN favorite_characters ON characters.id = favorite_characters.character_id")
      .group("characters.name")
      .select("characters.*, count(user_id) AS count_user")
      .order("count_user desc")
      .limit(limit)
  end

  def self.test
    Character.joins("LEFT JOIN favorite_characters ON user_id = favorite_characters.character_id")
    .group("characters.name")
    .select("characters.*, count(user_id)")
    .order("user_id desc")
    .limit(10)
  end

  def get_comics
    self.comics.pluck(:name)
  end

  def self.all_heros
    Character.pluck(:name)
  end
end
