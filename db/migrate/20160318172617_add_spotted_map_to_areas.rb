class AddSpottedMapToAreas < ActiveRecord::Migration[5.0]
  def change
    add_column :areas, :spotted_map, :string
  end
end
