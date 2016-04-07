require 'sinatra'
require "sinatra/base"
require 'twilio-ruby'
require 'tilt/erubis'

class TextSender
  @from_number = '+16147411418'
  @account_sid = 'ACc04f9281d461de6c00b324162400d76b' 
  @auth_token = '8c92d3581b56264671f3574e2dee0722'
  @client = Twilio::REST::Client.new @account_sid, @auth_token

  def self.send_text(content, number)
    @client.account.messages.create({
      from: @from_number, 
      to: number, 
      body: content  
    })
  end
end

class Main < Sinatra::Base
  enable :sessions
  set :session_secret, 'I never told anyone this, but...'

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
    session[:content] = params[:content]
    session[:phone_number] = params[:phone_number]
    begin
      TextSender::send_text(params[:content], params[:phone_number])
    rescue Exception => error
      puts error
      redirect to('/error_page')
    end
    redirect to "/you_sent"
  end

  run! if app_file == $0
end