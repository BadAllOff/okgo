class AddCoordinatesToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
    add_column :events, :gmap_zoom, :integer
  end
end
