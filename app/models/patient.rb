class Patient < ActiveRecord::Base
  has_many :patient_histories
  has_many :doctor_diagnoses
  has_many :comments
  mount_uploader :photo, ImageUploader
  validates :title,  presence:true,
                      inclusion: {in: ['Mr.','Ms.','Mrs.','Dr.']}

  validates :firstName, presence:true,
                        length:{maximum:20}

  validates :lastName,  presence:true,
                        length:{maximum:20}

  validates :gender, inclusion: {in: [true,false]}

  validates :dob, presence:true

  validates :bloodGroup,  presence:true,
                      inclusion: {in: ['A+','A-','B+','B-','AB+','AB-','O+','O-']}
  # validates_date :dob, :before => lambda { 18.years.ago },
  #                       :before_message => "Must be at least 18 years old"

  emailRegex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :email, format:{with:emailRegex},
                    length:{maximum:50}, allow_blank:true

  validates_length_of :streetAddress, maximum:50

  validates_length_of :city, maximum:20

  validates_length_of :country, maximum:20

  validates :phone, length:{maximum:30},
                    numericality:true, allow_blank:true

  #scope :get_history, lambda {|history_id| PatientHistory.where(id: history_id).first}

 # scope :destroy_patients, lambda

 def get_history(history_id)
    PatientHistory.where(id: history_id).first
  end

  def self.destroy_patients(patient_ids)
    destroy_all(id:patient_ids)
  end

  def self.destroy_patient(patient_id)
    destroy(patient_id)
  end

  def self.get_all_patients()
    all
  end

  def self.get_patients_paginated(start_index,end_index)

  end

  def histories
puts "****in history***"
    patient_histories
  end

  def diagnoses
puts "****in diagnoses***"
    doctor_diagnoses
  end

  def get_diagnosis(diagnosis_id)
    DoctorDiagnosis.where(id: diagnosis_id).first
  end

  def get_comment(comment_id)
    Comment.where(id: comment_id).first
  end

  def self.patient_diagnosis(diagnosis_id)
    DoctorDiagnosis.where(id: diagnosis_id).first
  end

  def _comments
    comments
  end

  def self.search_patient(firstName,lastName,age,gender,sortBy)

    puts gender

    if sortBy=='1'

      sort = 'firstName'
    elsif sortBy=='2'

      sort = 'lastName'

    elsif sortBy =='3'

      sort = 'dob'

    else

      sort = ''

    end

    if gender==''

      gen = [true,false];

    elsif gender=="true"

      gen = [true]

    else
      gen =[false]

    end

    if age !=''

    year = Date.today.year - age.to_i

      query = 'firstName like ? and lastName like ? and year(dob) = ? and gender in(?)'
      if (sort!=nil)
       query =query
      end

     where('firstName like ? and lastName like ? and year(dob) = ? and gender in(?)',"#{firstName}%","#{lastName}%",year,gen).order(sort)
  else

    where('firstName like ? and lastName like ? and gender in(?)',"#{firstName}%","#{lastName}%",gen).order(sort)
  end


  end

end
