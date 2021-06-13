
class CreateApplicationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(params)
    application = Application.new(name: params["name"], application_token: params["application_token"])    
    application.save
  end
end
