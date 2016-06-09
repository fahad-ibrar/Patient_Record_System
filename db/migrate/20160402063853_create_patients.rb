class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|

      #Basic Information
      t.string "title", :limit=>4,:null=>false
      t.string "firstName", :limit=>20,:null=>false
      t.string "lastName", :limit=>20,:null=>false
      t.boolean "gender", :null=>false #1=male, 0=female
      t.date "dob", :null=>false
      t.string "bloodGroup", :limit=>3,:null=>false

      #Contact
      t.string "phone", :limit=>30, :default=>""
      t.string "email", :limit=>50, :null=>true

      #Address
      t.text "streetAddress", :limit=>50
      t.string "city", :limit=>20, :default=>""
      t.string "country", :limit=>20, :default=>""
      t.timestamps null: false

      #Photo
      t.text "photo", :limit=>300
    end
  end
end
