class TextSender
  class << self
    FROM_NUMBER = '+16147411418'
    ACCOUNT_SID = 'ACc04f9281d461de6c00b324162400d76b' 
    AUTH_TOKEN = '8c92d3581b56264671f3574e2dee0722'

    def twilio_client
      Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    end

    def send_text(content, number)
      twilio_client.account.messages.create({
        from: FROM_NUMBER, 
        to: number, 
        body: content  
      })
    rescue Exception => e
      raise Exception, e
    end
  end
end