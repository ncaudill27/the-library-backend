class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      # t.references :club, null: false, foreign_key: true
      t.references :board, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
