class AddUserToNote < ActiveRecord::Migration
  def change
    change_table :notes do |t|
      t.references :user
    end
  end
end
