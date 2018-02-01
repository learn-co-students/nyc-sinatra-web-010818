class FiguresController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index.html'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new.html'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !params["landmark"]["name"].empty? && !params["title"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
      @figure.titles << Title.create(name: params["title"]["name"])
    elsif !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
    elsif !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])

    end
    # @figure.save
    # binding.pry
    redirect to "figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show.html'
  end


  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit.html'
  end
#
  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
    end
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    end
    # @figure.save
    redirect to "figures/#{@figure.id}"
  end

end
