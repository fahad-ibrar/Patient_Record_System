class CreatePatientHistories < ActiveRecord::Migration
  def change
    create_table :patient_histories do |t|

      t.date "date", :null=>false
      t.integer "patient_id", :null=>false
      t.integer "user_id", :null=>false
      t.text "detail", :null=>true
      t.timestamps null: false
    end
  end
end
