class DoctorDiagnosis < ActiveRecord::Base

  belongs_to :patient
  belongs_to :user

  def self.destroy_diagnoses(diagnosis_ids)
    destroy_all(id:diagnosis_ids)
  end

  def self.destroy_diagnosis(diagnosis_id)
    destroy(diagnosis_id)
  end

end
