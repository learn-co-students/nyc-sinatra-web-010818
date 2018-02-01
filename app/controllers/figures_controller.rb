class FiguresController < ApplicationController

## READ

get '/figures' do
  @figures = Figure.all
  erb :'figures/index'
end

## NEW
get '/figures/new' do
  @titles = Title.all
  @landmarks = Landmark.all
  erb :'figures/new'
end

post '/figures' do
  @figure = Figure.create(params[:figure])

  if !params[:title][:name].empty? ## New title exists
    @figure.titles << Title.create(params[:title])
  end

  if !params[:landmark][:name].empty? ## New landmark exists
    @figure.landmarks << Landmark.create(params[:landmark])
  end

  @figures = Figure.all
  erb :'/figures/index'
end

## UPDATE
get '/figures/:id/edit' do
  @figure = Figure.find(params[:id])
  @titles = Title.all
  @landmarks = Landmark.all
  erb :'figures/edit'
end

patch '/figures/:id' do
  @figure = Figure.find(params[:id])
  @figure.update(params[:figure])

  if !params[:title][:name].empty? ## New title exists
    @figure.titles << Title.create(params[:title])
  end

  if !params[:landmark][:name].empty? ## New landmark exists
    @figure.landmarks << Landmark.create(params[:landmark])
  end

  redirect "/figures/#{@figure.id}"
end

get '/figures/:id' do
  @figure = Figure.find(params[:id])

  erb :'figures/show'
end

end
