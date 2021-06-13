require 'securerandom'

class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show]

  # GET /applications
  def index
    @applications = Application.all

    render json: @applications
  end

  # GET /applications/1
  def show
    render json: @application
  end

  # POST /applications
  def create
    token = SecureRandom.uuid

    create_application_params = {
      "name" => params[:name],
      "application_token" => token
    }

    CreateApplicationWorker.perform_async(create_application_params)
    
    create_application_response = {
      "application_token" => create_application_params["application_token"]
    }

    render json: create_application_response, status: :accepted
  end

  # PATCH/PUT /applications/1
  def update
    @application = Application.lock.find_by(application_token: params[:application_token])
    if @application.update(application_params)
      render json: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find_by(application_token: params[:application_token])
      
      if @application.nil?
        render json: { message: "not found" }, status: :not_found
      end
    end

    # Only allow a trusted parameter "white list" through.
    def application_params
      params.require(:application).permit(:name)
    end
end