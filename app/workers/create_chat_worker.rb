class CreateChatWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(params)
    application = Application.find_by(application_token: params["application_token"])

    chat = Chat.new(number: application.chats_inc, application: application)
    
    if chat.save
      application.increment_chats_count
    end
  end
end
