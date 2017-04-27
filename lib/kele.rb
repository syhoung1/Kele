require 'httparty'
require 'json'
require './lib/roadmap.rb'

class Kele
  include HTTParty
  include Roadmap

  def initialize(n, p)
    @base_url = 'https://www.bloc.io/api/v1'
    @email = n
    @password = p
    response = self.class.post("#{@base_url}/sessions", body: { email: @email, password: @password })
    @auth_token = response['auth_token']
  end
  
  def get_me
    response = HTTParty.get("#{@base_url}/users/me", headers: { "authorization" => @auth_token})
    JSON.parse(response.body)
  end
  
  def get_mentor_availability(mentor_id)
    response = HTTParty.get("#{@base_url}/mentors/#{mentor_id}/student_availability", values: { id: mentor_id }, headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end
  
  def get_messages(page=nil)
    if page
      response = HTTParty.get("#{@base_url}/message_threads", values: { page: page }, headers: { "authorization" => @auth_token })
    else
      response = HTTParty.get("#{@base_url}/message_threads", headers: { "authorization" => @auth_token })
    end
    JSON.parse(response.body)
  end
  
  def create_message(recipient_id, text)
    HTTParty.post(
      "#{@base_url}/messages", 
      body: {
        sender: "#{@email}",
        recipient_id: recipient_id,
        "stripped-text" => text
      },
      headers: {
        "authorization" => @auth_token
      })
  end
end
