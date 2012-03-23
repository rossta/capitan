class Authentication < ActiveRecord::Base

  scope :provider, lambda { |provider| where(:provider => provider) }

  def self.sync(provider, authentication_data = [])
    authentication_data.each do |authentication_hash|
      authentication = find_or_initialize_by_provider_and_uid(provider.to_s, authentication_hash['id'].to_s)
      # github specifics
      authentication.name         = authentication_hash['login']
      authentication.provider_url = authentication_hash['url']

      authentication.save
    end
  end

  def sync(authentication_attributes = {})
    update_attributes(:email => authentication_attributes['email'], :html_url => authentication_attributes['html_url'])
  end

  def url
    html_url
  end
end
