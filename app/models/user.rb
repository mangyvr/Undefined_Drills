class User < ApplicationRecord

  # has_secure_password
  # validates :email, presence: true, uniqueness: true,
  #         format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # validates :password_confirmation, presence: true
  #has_many :drills
  #has_many :answers, dependent: :destroy
  #has_many :completed_drills, through: :drills, source: :user




  has_secure_password
  before_validation :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :first_name, presence: true, unless: :from_oauth?
  validates :last_name, presence: true, unless: :from_oauth?
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                                    format: VALID_EMAIL_REGEX,
                                    unless: :from_oauth?

  validates :email, presence: true, format:   /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
                                    unless:   :from_oauth?

  def full_name
    "#{first_name} #{last_name}".strip.squeeze(' ').titleize
  end

  def from_oauth?
    provider.present? && uid.present?
  end

  def sign_in_with_twitter?
    uid.present? && provider =='twitter'
  end

  def self.create_from_oauth(oauth_data)
    full_name = oauth_data['info']['name'].split
    user = User.create(
                        first_name: full_name[0],
                        last_name:  full_name[1] || 'unknown',
                        email:      oauth_data['info']['email'],
                        password:   SecureRandom.hex(32),
                        provider:   oauth_data['provider'],
                        uid:        oauth_data['uid'],
                        oauth_token: oauth_data['credentials']['token'],
                        oauth_secret: oauth_data['credentials']['secret'],
                        oauth_raw_data: oauth_data
    )
  end

  # def generate_api_key
  #   loop do
  #     self.api_key = SecureRandom.hex(32)
  #     break unless User.exists?(api_key: api_key)
  #   end
  # end

  def self.find_from_oauth(oauth_data)
    User.where(
              provider: oauth_data['provider'],
              uid: oauth_data['uid']).first
  end

  def downcase_email
    self.email.downcase! if email.present?
  end

  # For password reset
   def self.new_token
     SecureRandom.urlsafe_base64
   end

   # Generates password reset link with unencrypted token before it is digest-ed
   def gen_reset_link(url, token)
     "#{url}/reset_password/#{token}/edit?email=#{self.email}"
   end

   # Use bcrypt to convert unhashed token into digest
   def self.hash_token(token)
     BCrypt::Password.create(token)
   end

end
