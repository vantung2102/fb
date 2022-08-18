class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[facebook]

    # validates :phone, phone_number: true

    has_many :posts, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :group_users, dependent: :destroy
    has_many :groups, :through => :group_users
    has_many :notifications, as: :recipient



    def self.from_omniauth(auth)
      result = User.find_by(email: auth.info.email)
      return result if result
  
      where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.username = auth.info.name.split('@').first
        user.uid = auth.uid
        user.provider = auth.provider
      end
    end

    class << self
      def new_token
        SecureRandom.urlsafe_base64
      end
    end
  
    def generate_token
      api_token = User.new_token
      update_attribute(:api_token_digest, api_token)
      api_token
    end
  
    def self.digest(string)
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end
end