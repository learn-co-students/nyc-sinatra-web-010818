class FiguresController < ApplicationController
  set :views, 'app/views/figures'

  get '/figures' do
    @figures = Figure.all
    erb :'index.html'
  end

  post '/figures' do
    new_figure = Figure.create(name: params[:figure][:name])
    landmark_ids = params[:figure][:landmark_ids]
    if landmark_ids  #one/more boxes checked
      landmark_ids.each do |id|
        checked_landmark = Landmark.find(id)
        checked_landmark.figure = new_figure
        checked_landmark.save
      end
    else  #new landmark
      new_landmark = Landmark.create(params[:landmark])
      new_landmark.figure = new_figure
      new_landmark.save
    end

    title_ids = params[:figure][:title_ids]
    if title_ids
      title_ids.each do |id|
        checked_title = Title.find(id)
        checked_title.figures << new_figure
        checked_title.save
      end
    else
      new_title = Title.create(params[:title])
      new_title.figures << new_figure
      new_title.save
    end

    redirect "/figures/#{new_figure.id}"
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'new.html'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'edit.html'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'show.html'
  end

  patch '/figures/:id' do
    figure = Figure.find(params[:id])
    figure.name = params[:figure][:name]
    figure.save

    landmark_ids = params[:figure][:landmark_ids]
    if landmark_ids
      landmark_ids.each do |id|
        checked_landmark = Landmark.find(id)
        checked_landmark.figure = figure
        checked_landmark.save
      end
    end
    if params[:landmark][:name]
      new_landmark = Landmark.create(params[:landmark])
      new_landmark.figure = figure
      new_landmark.save
    end

    title_ids = params[:figure][:title_ids]
    if title_ids
      title_ids.each do |id|
        checked_title = Title.find(id)
        checked_title.figures << figure
        checked_title.save
      end
    end
    if params[:title][:name]
      new_title = Title.create(params[:title])
      new_title.figures << figure
      new_title.save
    end

    redirect "/figures/#{figure.id}"
  end


end
