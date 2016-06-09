class Department < ActiveRecord::Base

  has_many :users

  def self.get_all_departments()
    pluck(:name,:id)
  end

end
