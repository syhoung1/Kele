require 'httparty'
require 'json'
require './lib/roadmap.rb'
require 'pry'

class Kele
  include HTTParty
  include Roadmap

  def initialize(n, p)
    @base_url = 'https://www.bloc.io/api/v1'
    response = self.class.post("#{@base_url}/sessions", body: { email: n, password: p })
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
  
  def create_message(email, recipient_id, text)
    HTTParty.post(
      "#{@base_url}/messages", 
      body: {
        sender: email,
        recipient_id: recipient_id,
        "stripped-text" => text
      },
      headers: {
        "authorization" => @auth_token
      })
  end
  
  def create_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment, enrollment_id)
    response = HTTParty.post("#{@base_url}/checkpoint_submissions", body: {
      assignment_branch: assignment_branch,
      assignment_commit_link: assignment_commit_link,
      checkpoint_id: checkpoint_id,
      comment: comment,
      enrollment_id: enrollment_id
    },
    headers: { "authorization" => @auth_token })
    
    JSON.parse(response.body)
  end
end
