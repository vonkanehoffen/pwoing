class AddUrlNameToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :url_name
    end
  end
end
