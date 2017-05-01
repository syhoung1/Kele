require 'pry'

module Roadmap
  def get_roadmap(roadmap_id)
    response = HTTParty.get("#{@base_url}/roadmaps/#{roadmap_id}", values: { id: roadmap_id }, headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end
  
  def get_checkpoint(checkpoint_id)
    response = HTTParty.get("#{@base_url}/checkpoints/#{checkpoint_id}", values: { id: checkpoint_id }, headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end
end