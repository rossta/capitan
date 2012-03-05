class User < ActiveRecord::Base

  scope :provider, lambda { |provider| where(:provider => provider) }

  def self.sync(provider, user_data = [])
    user_data.each do |user_hash|
      user = find_or_initialize_by_provider_and_uid(provider.to_s, user_hash['id'])
      # github specifics
      user.name         = user_hash['login']
      user.provider_url = user_hash['url']

      user.save
    end
  end

  def sync(user_attributes = {})
    update_attributes(:email => user_attributes['email'], :html_url => user_attributes['html_url'])
  end

end
