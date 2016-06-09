class Comment < ActiveRecord::Base

  belongs_to :patient
  belongs_to :user

  def self.destroy_comments(comment_ids)
    destroy_all(id:comment_ids)
  end

  def self.destroy_comment(comment_id)
    destroy(comment_id)
  end
end
