class CreateRenters < ActiveRecord::Migration[5.0]
  def change
    create_table :renters do |t|
      t.string :title
      t.float :rate
      t.date :date_start
      t.date :date_end
      t.float :account
      t.references :area, foreign_key: true

      t.timestamps
    end
  end
end
