class User < ActiveRecord::Base
  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  validates_presence_of :email, :full_name, :location
  validates_length_of :bio, minimum: 30, allow_blank: false
  validates_uniqueness_of :email
  validates_format_of :email, with: EMAIL_REGEXP

  has_secure_password

  before_create do |user|
    user.confirmation_token = SecureRandom.urlsafe_base64
  end
  
  scope :confirmed, ->  { where.not(confirmed_at: nil) }
  
  def confirm!
    return if confirmed?
    self.confirmation_token = ''
    self.confirmed_at = DateTime.now
    save!
  end
  
  def confirmed?
    self.confirmed_at.present?
  end
  
  def	self.authenticate(email,	password)
    user	=	confirmed.find_by(email:	email).try(:authenticate,	password)
  end
end
