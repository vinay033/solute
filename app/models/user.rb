class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :company_name, presence: true
  validates :dob, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :image, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :image, :reject_if => lambda { |a| a[:avatar].blank? }, :allow_destroy => true

  has_many :projects
  
  def profile_image
    image.nil? ? "avatar.png" : image.avatar.url
  end
end
