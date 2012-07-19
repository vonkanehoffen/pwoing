class User < ActiveRecord::Base
  
  has_many :notes
  
  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.url_name = auth["info"]["name"].downcase.gsub(/[^a-z0-9]+/i, '-')
    end
  end
end
