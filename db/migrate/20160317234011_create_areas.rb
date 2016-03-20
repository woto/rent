class CreateAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :areas do |t|
      t.references :map, foreign_key: true

      t.string :ref
      t.string :title
      t.string :spotted_map
      t.float :square

      t.timestamps
    end
  end
end
