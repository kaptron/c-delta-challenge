class AddColorToCreativeQualities < ActiveRecord::Migration[5.0]
  def change
    add_column :creative_qualities, :color, :string
  end
end
