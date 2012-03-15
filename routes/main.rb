class App < Sinatra::Application

  get '/' do
    slim :index
  end

end