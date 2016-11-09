class PetsController < ApplicationController
  def index
    pets = Pet.all

    render :json => pets.as_json(), :status => :ok

  end

  def show
    pet = Pet.find_by(id: params[:id])


    if pet
      render :json => pet.as_json(), :status => :ok
    else
      render :json => [], :status => :no_content
    end
  end

  def create
    puts ">>>>> CKC: #{request.body.read}"
    puts ">>>>> CKC: #{params}"
    Pet.create(pet_params)
    render json: {}, status: :created
  end

  def search
    pet = Pet.where(name: params[:query].capitalize)
    #.where returns an array of all match name, whereas .find_by only find the first match value.

    unless pet.empty?
      render :json => pet.as_json(), :status => :ok
    else
      render :json => ["No pet found"], :status => :no_content
    end
  end

  private
    def pet_params
      params.require(:pet).permit(:name, :age, :human)
    end
end
