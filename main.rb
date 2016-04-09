require 'sinatra'
require 'twilio-ruby'
require 'tilt/erubis'
require_relative 'twilio_client'
require_relative 'message_worker'

class Main < Sinatra::Base
  enable :sessions
  set :session_secret, 'I never told anyone this, but...'
  set :show_exceptions, :after_handler

  get '/' do
    erb :form
  end 

  get '/you_sent' do
    @content = session[:content]
    @phone_number = session[:phone_number]
    erb :you_sent
  end

  get '/error_page' do
    @error = session[:error]
    erb :error_page
  end

  post '/' do
    MessageWorker.perform_async(params[:content], params[:phone_number])

    session[:content] = params[:content]
    session[:phone_number] = params[:phone_number]
    redirect "/you_sent"
  end

  error do
    error = env['sinatra.error']
    puts error.message
    session[:error] = error.message
    redirect '/error_page'
  end

  run! if app_file == $0
end