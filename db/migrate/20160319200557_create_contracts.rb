class CreateContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :contracts do |t|
      t.string :title
      t.references :renter, foreign_key: true
      t.references :area, foreign_key: true
      t.float :rate
      t.date :date_start
      t.date :date_end

      t.timestamps
    end
  end
end
