class Invitation < ActiveRecord::Base 
  belongs_to :project

  def invited_user
    User.find(self.invited_user_id) rescue nil
  end
end
