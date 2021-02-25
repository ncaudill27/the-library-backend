class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.references :club, null: false, foreign_key: true
      # t.references :creator, null: false, foreign_key: true

      t.string :title

      t.timestamps
    end
  end
end
