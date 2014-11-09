require 'json'

class Slacker < Sinatra::Base

  get '/' do
    erb :index
  end
  
  post '/message.json' do
    params.merge(status: :ok).to_json
  end

  run! if app_file == $0
end
