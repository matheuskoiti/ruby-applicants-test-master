class ModelsController < ApplicationController
  expose(:make) { Make.by_webmotor_id(params[:webmotors_make_id]) } 
  expose(:models) { Model.by_make_id(make.id) }
  def index
    #search the models
    uri = URI("http://www.webmotors.com.br/carro/modelos")

    # Make request for Webmotors site
    make = Make.by_webmotor_id(params[:webmotors_make_id])

    response = Net::HTTP.post_form(uri, { marca: params[:webmotors_make_id] })
    models_json = JSON.parse response.body

    # debugger

    # Itera no resultado e grava os modelos que ainda não estão persistidas
    models_json.each do |json|
      if Model.where(name: json["Nome"], make_id: make.id).size == 0
        Model.create(make_id: make.id, name: json["Nome"])
      end
    end
  end
end
