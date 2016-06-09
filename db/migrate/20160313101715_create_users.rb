class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      #Basic Information
      t.string "email", :limit=>50, :null=>false
      t.string "password_digest", :null=>false
      t.string "firstName", :limit=>20,:null=>false
      t.string "lastName", :limit=>20,:null=>false
      t.boolean "gender", :null=>false #1=male, 0=female
      t.date "dob", :null=>false

      #User Type 0=admin, 1=doctor
      t.integer "userType", :null=>false

      #Work Information
      t.integer "department_id", :null=>false
      t.string "designation", :limit=>30, :default=>""
      t.string "specialization", :limit=>50, :default=>""

      #Address
      t.text "streetAddress", :limit=>50
      t.string "city", :limit=>20, :default=>""
      t.string "country", :limit=>20, :default=>""

      #Contact
      t.string "phone", :limit=>30, :default=>""

      #About
      t.text "about", :limit=>100

      #Status
      t.text "status", :limit=>100

      #Photo
      t.text "photo", :limit=>300

      #Verify
      t.boolean "verifyStatus", :null=>false, :default=>false
      t.string "verifyToken", :limit=>50

      t.timestamps null: false


    end

    add_index("users","email",unique: true)
    add_index("users","verifyToken",unique: true)
  end
end
