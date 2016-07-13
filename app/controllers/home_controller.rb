class HomeController < ApplicationController
  before_action :populate, only: :index

  expose(:makes) { Make.all } 
  
  def index
  end

  private

  def populate
    #search the make
    uri = URI("http://www.webmotors.com.br/carro/marcas")

    # Make request for Webmotors site
    response = Net::HTTP.post_form(uri, {})
    json = JSON.parse response.body

    create_makes(json)
  end

  # Itera no resultado e grava as marcas que ainda não estão persistidas
  def create_makes(json)
    json.each do |make_params|
      unless makes.contains?(make_params["Nome"]) 
        Make.create(name: make_params["Nome"], webmotors_id: make_params["Id"])
      end
    end
  end
end
