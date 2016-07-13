class HomeController < ApplicationController
  expose(:makes) { Make.all } 
  
  def index
    #search the make
    uri = URI("http://www.webmotors.com.br/carro/marcas")

    # Make request for Webmotors site
    response = Net::HTTP.post_form(uri, {})
    json = JSON.parse response.body

    create_makes(json)
  end

  private

  # Itera no resultado e grava as marcas que ainda não estão persistidas
  def create_makes(json)
    json.each do |make_params|
      if makes.by_name(make_params["Nome"]).size == 0
        Make.create(name: make_params["Nome"], webmotors_id: make_params["Id"])
      end
    end
  end
end
