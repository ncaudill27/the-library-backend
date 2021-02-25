class CreateClubs < ActiveRecord::Migration[6.0]
  def change
    create_table :clubs do |t|
      t.string :name
      t.text :description
      t.string :avatar
      t.string :active_book_isbn13

      t.timestamps
    end
  end
end
