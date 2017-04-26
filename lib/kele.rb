require 'httparty'

class Kele
  include HTTParty

  def initialize(n, p)
    @base_url = 'https://www.bloc.io/api/v1'
    @credentials = { body: { email: n, password: p } }
    response = self.class.post("#{@base_url}/sessions", @credentials )
    @auth_token = response['auth_token']
  end
end
