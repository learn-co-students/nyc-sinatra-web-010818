class LandmarksController < ApplicationController
  set :views, 'app/views/landmarks'

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'index.html'
  end

  get '/landmarks/new' do
    @figures = Figure.all
    erb :'new.html'
  end

  post '/landmarks' do
    @new_landmark = Landmark.create(params[:landmark])
    if !params[:figure_name].empty?   #create new figure with name
      figure = Figure.create(name: params[:figure_name])
    elsif params[:figure_id]  #associate existing figure
      figure = Figure.find(params[:figure_id])
    end
    @new_landmark.figure = figure
    @new_landmark.save
    redirect "/landmarks/#{@new_landmark.id}"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'show.html'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    @figures = Figure.all
    erb :'edit.html'
  end

  patch '/landmarks/:id' do

    landmark = Landmark.find(params[:id])
    landmark.name = params[:landmark][:name]
    landmark.year_completed = params[:landmark][:year_completed]

    if !params[:figure_name].empty?
      figure = Figure.create(name: params[:figure_name])
    else
      figure = Figure.find(params[:figure_id])
    end
    landmark.figure = figure
    landmark.save

    redirect "/landmarks/#{landmark.id}"
  end






  #
  # get '/figures/:id/edit' do
  #   @figure = Figure.find(params[:id])
  #   @landmarks = Landmark.all
  #   @titles = Title.all
  #   erb :'edit.html'
  # end
  #

  #
  # patch '/figures/:id' do
  #   figure = Figure.find(params[:id])
  #   figure.name = params[:figure][:name]
  #   figure.save
  #
  #   landmark_ids = params[:figure][:landmark_ids]
  #   if landmark_ids
  #     landmark_ids.each do |id|
  #       checked_landmark = Landmark.find(id)
  #       checked_landmark.figure = figure
  #       checked_landmark.save
  #     end
  #   end
  #   if params[:landmark][:name]
  #     new_landmark = Landmark.create(params[:landmark])
  #     new_landmark.figure = figure
  #     new_landmark.save
  #   end
  #
  #   title_ids = params[:figure][:title_ids]
  #   if title_ids
  #     title_ids.each do |id|
  #       checked_title = Title.find(id)
  #       checked_title.figures << figure
  #       checked_title.save
  #     end
  #   end
  #   if params[:title][:name]
  #     new_title = Title.create(params[:title])
  #     new_title.figures << figure
  #     new_title.save
  #   end
  #
  #   redirect "/figures/#{figure.id}"
  # end


end
