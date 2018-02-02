class FiguresController < ApplicationController

  get '/figures/new' do
    @landmarks=Landmark.all
    @titles=Title.all
    erb :'figures/new'
  end

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/:id/edit' do
    @figure=Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  get '/figures/:id' do
    @figure=Figure.find(params[:id])
    erb :'figures/show'
  end

  post '/figures' do
    @figure=Figure.create(params[:figure])
    if !params[:landmark][:name].empty?
      @figure.landmarks<<Landmark.create(params[:landmark])
    end
    if !params[:title][:name].empty?
      @figure.titles<<Title.create(params[:title])
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

end
