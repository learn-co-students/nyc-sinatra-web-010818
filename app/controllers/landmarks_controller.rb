class LandmarksController < ApplicationController

 configure do
    set :public_folder, 'public'
    set :views, 'app/views/landmarks'
  end

  get "/landmarks" do
    @landmarks = Landmark.all
    erb :index
  end


  get "/landmarks/new" do
    @figures = Figure.all
    erb :new
  end

  get "/landmarks/:id" do

    @landmark = Landmark.find(params[:id])

    erb :show
  end

  get "/landmarks/:id/edit" do
    @landmark = Landmark.find(params[:id])


    erb :edit

  end

  post "/landmarks" do
    @landmark = Landmark.create(params[:landmark])
    redirect "/landmarks/#{@landmark.id}"
  end






  patch "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])
    @landmark.update(params[:landmark])

    @landmark.save

    redirect "/landmarks/#{@landmark.id}"

  end


end
