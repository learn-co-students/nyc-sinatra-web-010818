class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end


  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !params[:title][:name].empty?
      @title = Title.create(params[:title])
      FigureTitle.create(figure_id: @figure.id, title_id: @title.id)
    else
      FigureTitle.create(figure_id: @figure.id, title_id: params[:figure][:title_id])
    end

    if !params[:landmark][:name].empty?
      @landmark = Landmark.create(name:params[:landmark][:name], figure_id: @figure.id, year_completed:Time.new.year)
      @figure.landmarks << @landmark
    end
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if !params[:title][:name].empty?
      @title = Title.create(params[:title])
      FigureTitle.create(figure_id: @figure.id, title_id: @title.id)
    else
      FigureTitle.create(figure_id: @figure.id, title_id: params[:figure][:title_id])
    end
    if !params[:landmark][:name].empty?
      @landmark = Landmark.create(name:params[:landmark][:name], figure_id: @figure.id, year_completed:Time.new.year)
      @figure.landmarks << @landmark
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end












end
