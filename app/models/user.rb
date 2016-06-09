class User < ActiveRecord::Base
  mount_uploader :photo, ImageUploader
  has_secure_password
  belongs_to :department
  has_many :patient_histories
  has_many :doctor_diagnoses
  has_many :comments
  has_many :queries

  validates :firstName, presence:true,
                        length:{maximum:20}

  validates :lastName,  presence:true,
                        length:{maximum:20}

  validates :gender, inclusion: {in: [true,false]}

  validates :dob, presence:true
  validates_date :dob, :before => lambda { 18.years.ago },
                        :before_message => "Must be at least 18 years old"

  emailRegex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :email, uniqueness:true,
                    format:{with:emailRegex},
                    length:{maximum:50}

  validates :password, confirmation:{ :if => :validate_password? },
                    length:{within: 6..20, :if => :validate_password?}

  validates :department_id, presence:true,
                            inclusion:{in: Department.pluck(:id)}

  validates_length_of :designation, maximum:30

  validates_length_of :specialization, maximum:50

  validates_length_of :streetAddress, maximum:50

  validates_length_of :city, maximum:20

  validates_length_of :country, maximum:20

  validates :phone, length:{maximum:30},
                    numericality:true, allow_blank:true

  def self.details(email_id)
    where(email: email_id)
  end

  def self.with_email(email_id)
    where(email:email_id).first
  end

  def department_name()
    department.name
  end
  private

  def validate_password?
    password.present? || password_confirmation.present?
  end


  # def details
  #   self
  # end
end
