class AddSlugToScreencasts < ActiveRecord::Migration
  def change
    add_column :screencasts, :slug, :string
    add_index :screencasts, :slug, unique: true
  end
end
