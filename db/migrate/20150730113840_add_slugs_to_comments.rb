class AddSlugsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :slug, :string
  end
end
