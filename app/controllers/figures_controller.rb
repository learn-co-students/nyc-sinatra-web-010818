class FiguresController < ApplicationController
set :views, 'app/views/figures'


  get '/figures' do
    @figures = Figure.all
    erb :index
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :new
  end

  post '/figures' do
    if params[:landmark][:name].empty? && params[:title][:name].empty?
      @figure = Figure.create(params[:figure])
    elsif !params[:landmark][:name].empty? && params[:title][:name].empty?
      landmark = Landmark.create(params[:landmark])
      @figure = Figure.create(params[:figure])
      @figure.landmarks << landmark
    elsif params[:landmark][:name].empty? && !params[:title][:name].empty?
      title = Title.create(params[:title])
      @figure = Figure.create(params[:figure])
      @figure.titles << title
    else
      landmark = Landmark.create(params[:landmark])
      @figure = Figure.create(params[:figure])
      @figure.landmarks << landmark
      title = Title.create(params[:title])
      @figure.titles << title
    end

    redirect "/figures/#{figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :show
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :edit
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    # binding.pry
    if params[:landmark][:name].empty? && params[:title][:name].empty?
      @figure.update(params[:figure])
    elsif !params[:landmark][:name].empty? && params[:title][:name].empty?
      landmark = Landmark.create(params[:landmark])
      @figure.update(params[:figure])
      @figure.landmarks << landmark
    elsif params[:landmark][:name].empty? && !params[:title][:name].empty?
      title = Title.create(params[:title])
      @figure.update(params[:figure])
      @figure.titles << title
    else
      landmark = Landmark.create(params[:landmark])
      @figure.update(params[:figure])

      @figure.landmarks << landmark
      title = Title.create(params[:title])
      @figure.titles << title
    end
    redirect "/figures/#{@figure.id}"
  end



end
