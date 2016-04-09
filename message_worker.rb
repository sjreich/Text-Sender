require 'sidekiq'

class MessageWorker
  include Sidekiq::Worker

  def perform(content, number)
    TwilioClient::send_text(content, number)
  end
end