class PetsController < ApplicationController
  def index
    @pets = Pet.all

    render :json => @pets.as_json(:only => [:id, :name, :human, :age]), :status => :ok

  end

  def show
    pet = Pet.find_by(id: params[:id])


    if pet
      render :json => pet.as_json(:only => [:id, :name, :human, :age]), :status => :ok
    else
      render :json => [], :status => :no_content
    end
  end

  def search
    pet = Pet.where(name: params[:query].capitalize)
    #.where returns an array of all match name, whereas .find_by only find the first match value.

    unless pet.empty?
      render :json => pet.as_json(:only => [:id, :name, :human, :age]), :status => :ok
    else
      render :json => ["No pet found"], :status => :no_content
    end
  end
end
