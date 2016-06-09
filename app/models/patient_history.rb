class PatientHistory < ActiveRecord::Base

  belongs_to :patient
  belongs_to :user

  def self.destroy_histories(history_ids)
    destroy_all(id:history_ids)
  end

  def self.destroy_history(history_id)
    destroy(history_id)
  end

end
