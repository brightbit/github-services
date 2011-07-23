class Service::Kikuchat < Service
  include HTTParty
  
  string :url, :api_user, :api_key, :room_id
  def receive_push
    self.class.base_uri data['url']
    self.class.basic_auth data['api_user'], data['api_key']
    
    messages = []
    messages << "#{summary_message}: #{summary_url}"
    messages += commit_messages.first(3)

    messages.each do |message|
      self.class.post "/room/#{data['room_id']}/messages.json", :query => { :message => "#{message}" }
    end
  end
end
