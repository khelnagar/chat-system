class CreateMessageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(params)
    application = Application.find_by(application_token: params["application_token"])
    chat = application.chats.find_by(number: params["number"])

    message = Message.new(content: params["content"], number: chat.messages_inc, chat: chat)

    if message.save
      chat.increment_messages_count
    end
  end
end
