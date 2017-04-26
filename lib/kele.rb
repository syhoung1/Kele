require 'httparty'
require 'json'

class Kele
  include HTTParty

  def initialize(n, p)
    @base_url = 'https://www.bloc.io/api/v1'
    @credentials = { body: { email: n, password: p } }
    response = self.class.post("#{@base_url}/sessions", @credentials )
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
end
