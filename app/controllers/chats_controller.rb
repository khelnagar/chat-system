class ChatsController < ApplicationController
  before_action :set_application, only: [:index, :show, :create, :update]

  # GET /chats
  def index
    @chats = @application.chats

    render json: @chats
  end

  # GET /chats/1
  def show
    @chat = @application.chats.find_by(number: params[:number])
    
    if @chat.nil?
      render json: { message: "not found" }, status: :not_found
    else
      render json: @chat
    end    
  end

  # POST /chats
  def create
    create_chat_params = {
      "application_token" => params[:application_application_token] 
    }

    CreateChatWorker.perform_async(create_chat_params)
    
    # the number that eventually be taken by chat if created successfully
    chat_number = @application.chats_inc
    
    create_chat_response = {
      "number" => chat_number
    }

    render json: create_chat_response, status: :accepted
  end

  # PATCH/PUT /chats/1
  def update
    @chat = @application.chats.find_by(number: params[:number])

    render json: @chat
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find_by(application_token: params[:application_application_token])

      if @application.nil?
        render json: { message: "not found" }, status: :not_found
      end
    end
end
