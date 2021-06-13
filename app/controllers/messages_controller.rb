class MessagesController < ApplicationController
  before_action :set_chat, only: [:index, :show, :create, :update]

  # GET /messages
  def index
    @messages = @chat.messages

    render json: @messages
  end

  # GET /messages/1
  def show
    @message = @chat.messages.find_by(number: params[:number])
    
    if @message.nil?
      render json: { message: "not found" }, status: :not_found
    else
      render json: @message
    end 
  end

  # POST /messages
  def create
    create_message_params = {
      "application_token" => params[:application_application_token], 
      "number" => params[:chat_number], 
      "content" => params[:content] 
    }

    CreateMessageWorker.perform_async(create_message_params)
    
    # the number that eventually be taken by message if created successfully
    message_number = @chat.messages_inc
    
    create_message_response = {
      "number" => message_number
    }

    render json: create_message_response, status: :accepted
  end

  # PATCH/PUT /messages/1
  def update
    @message = @chat.messages.lock.find_by(number: params[:number])
    
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @application = Application.find_by(application_token: params[:application_application_token])

      @chat = @application.present? ? @application.chats.find_by(number: params[:chat_number]) : nil

      if @chat.nil?
        render json: { message: "not found" }, status: :not_found
      end
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:content)
    end
end
