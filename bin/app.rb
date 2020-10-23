require "pry"
require_relative "../config/environment.rb"

def top_character_most_fans
  # Find Top Character With Most Fans
  prompt = TTY::Prompt.new
  limit = prompt.slider("Limit ", max: 10, step: 1, default: 5)
  character = Character.top_char(limit)

  # Print using table
  table = TTY::Table.new(header: ["No", "Name", "Total"])
  character.each_with_index { |character, index|
    table << [index + 1, character.name, character.users.count]
  }
  puts table.render(:ascii)
  puts ""
end

def most_expensive_comics
  # Find Top Most Expensive Comics
  prompt = TTY::Prompt.new
  limit = prompt.slider("Limit ", max: 30, step: 5, default: 10)  
  comics = Comic.most_expensive_comics(limit)

  # Print using table
  table = TTY::Table.new(header: ["No", "Name", "Price"])
  comics.each_with_index { |comic, index|
    table << [index + 1, comic.name, comic.price]
  }
  puts table.render(:ascii)
  puts ""
end

def find_all_comic_by_character
  # Find All Of A Character's Comics
  prompt = TTY::Prompt.new
  choices = Character.pluck(:name)
  character = prompt.select("Choose A Character!", choices)
  comics = Character.find_by(name: character).get_comics()

  # Print using table
  table = TTY::Table.new(header: ["No", "Name"])
  comics.each_with_index { |comic, index|
    table << [index + 1, comic]
  }
  puts table.render(:ascii)
  puts ""
end

def recommended_comics
  # Recommended Comics For A Specific User
  prompt = TTY::Prompt.new
  choices = User.pluck(:name)
  user = prompt.select("Choose A User!", choices)
  comics = User.find_by(name: user).comic_reccomendations()

  # Print using table
  table = TTY::Table.new(header: ["No", "Name"])
  comics.each_with_index { |comic, index|
    table << [index + 1, comic]
  }
  puts table.render(:ascii)
  puts ""
end

def find_a_character_fans()
  # Find A Character's Fans
  prompt = TTY::Prompt.new
  choices = Character.pluck(:name)
  character = prompt.select("Choose a character!", choices)
  user = Character.find_by(name: character).get_fans()

  # Print using table
  table = TTY::Table.new(header: ["No", "Name"])
  user.each_with_index { |user, index|
    table << [index + 1, user]
  }
  puts table.render(:ascii)
  puts ""
end

def main
  puts TTY::Box.frame "Welcome to Marvelous Analytics!"

  number = 0
  while (number != 6)
    prompt = TTY::Prompt.new
    number = prompt.select("How can I help you?", cycle: true) do |menu|
      menu.enum "."

      menu.choice "Find Top Characters With Most Fans", 1
      menu.choice "Find Top Most Expensive Comics", 2
      menu.choice "Find All Of A Character's Comics", 3
      menu.choice "Recommended Comics For A User", 4
      menu.choice "Find A Character's Fans", 5
      menu.choice "Exit", 6
    end

    if number == 1
      top_character_most_fans()
    elsif number == 2
      most_expensive_comics()
    elsif number == 3
      find_all_comic_by_character()
    elsif number == 4
      recommended_comics()
    elsif number == 5
      find_a_character_fans()
    elsif number == 6
      return
    end

    unless prompt.yes?("Do you want to continue?")
      number = 6
    end
  end
end

main()