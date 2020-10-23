class CreateComicTable < ActiveRecord::Migration[5.2]
  def change
    create_table :comics do |t|
      t.string :name
      t.float :price
    end
  end
end
