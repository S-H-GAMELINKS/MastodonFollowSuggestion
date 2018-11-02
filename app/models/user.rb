class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    puts auth
      
    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        domain: User.get_domain(auth),
        token: auth.credentials.token
      )
      user.save!
    end
    current_user = user
  end
      
  private
      
  def self.dummy_email(auth)
    "#{auth.uid}"
  end

  def self.get_domain(auth)
    auth.uid.to_s.gsub(/#{auth.info.name.to_s.downcase}\@/, "")
  end
end
