class AddDashboardMapToMaps < ActiveRecord::Migration[5.0]
  def change
    add_column :maps, :dashboard_map, :string
  end
end
