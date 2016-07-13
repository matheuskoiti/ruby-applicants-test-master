class ModelsController < ApplicationController
  before_action :populate, only: :index

  expose(:make) { Make.by_webmotor_id(params[:webmotors_make_id]) } 
  expose(:models) { Model.by_make_id(make.id) }
  expose(:all_models) { Model.all }

  def index
  end

  private

  def populate
    #search the models
    uri = URI("http://www.webmotors.com.br/carro/modelos")

    response = Net::HTTP.post_form(uri, { marca: params[:webmotors_make_id] })
    models_json = JSON.parse response.body

    create_models(models_json)
  end

  # Itera no resultado e grava os modelos que ainda não estão persistidas
  def create_models(models_json) 
    models_json.each do |json|
      if not_inserted_yet?(json["Nome"], make.id) 
        Model.create(make_id: make.id, name: json["Nome"])
      end
    end
  end

  def not_inserted_yet?(name, make_id)
    all_models.by_name_and_make_id(name, make_id).size == 0
  end
end
