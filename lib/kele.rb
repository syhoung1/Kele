class Kele
  include HTTPartys
  
  def initialize(n, p)
    @base_url = https://www.bloc.io/api/v1
    @auth = { username: n, password: p }
    @auth_token = self.class.post('https://www.bloc.io/api/v1/sessions', @auth)
  end

  self.test = puts "hello"
end
