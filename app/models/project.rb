class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
  has_many :invitations, :dependent => :destroy
  has_one :image, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :image, :reject_if => lambda { |a| a[:avatar].blank? }, :allow_destroy => true

  validates :name, presence: true
  validates :submission_date, presence: true
  validates :description, presence: true

  def project_picture
    image.nil? ? "no_image.png" : image.avatar.url
  end

  def creater
    user.name
  end

  def admin?(login_user)
    user == login_user
  end
end
