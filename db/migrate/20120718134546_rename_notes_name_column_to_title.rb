class RenameNotesNameColumnToTitle < ActiveRecord::Migration
  def change
    rename_column :notes, :name, :title
  end
end
