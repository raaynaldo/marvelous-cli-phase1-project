class Comic < ActiveRecord::Base
  has_many :character_comics
  has_many :characters, through: :character_comics

  def get_characters
    self.characters.map { |character| character.name }
  end

  def self.get_by_name(name)
    Comic.find_by(name: name)
  end

  def self.highest_price
    Comic.maximum(:price)
  end

  def self.most_expensive_comics(int)
    Comic.order('price desc').limit(int)
  end

  def self.lowest_minimum
    Comic.maximum(:price)
  end

  def self.all_comics
    Comic.pluck(:name)
  end
end
