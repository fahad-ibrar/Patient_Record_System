class Query < ActiveRecord::Base

  belongs_to :user

  def self.doctor_queries(doc_id)
    where(user_id:doc_id)
  end

  def self.all_queries
    all
  end
end
