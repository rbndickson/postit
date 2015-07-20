class ChangeColumnNames < ActiveRecord::Migration
  def change
    rename_column :votes, :voteable_id, :votable_id
    rename_column :votes, :voteable_type, :votable_type
  end
end
