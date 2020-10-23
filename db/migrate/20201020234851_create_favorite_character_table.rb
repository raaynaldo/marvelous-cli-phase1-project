class CreateFavoriteCharacterTable < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_characters do |t|
      t.integer :user_id
      t.integer :character_id
    end
  end
end
