class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.text "subject", :null=>false, :limit=>100
      t.text "message", :null=>false
      t.text "response"
      t.integer "user_id", :null=>false
      t.timestamps null: false
    end
  end
end
