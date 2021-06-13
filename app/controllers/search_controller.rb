class SearchController < ApplicationController
    before_action :set_chat

	def search
   	    @messages = []
		if params[:q].present?
	      	@messages = Message.search(
	      		{
			      _source: false,
				  query: { 
				    bool: { 
				      must: [
				        { match_phrase_prefix: { 
				        	content: {query: params[:q]}
				        }}
				      ],
				      filter: [ 
				        { term:  { chat_id: @chat.id }}
				      ]
				    }
				  },
				  fields: ["number", "content"]
			    }
	      	).select { |m| m.delete("_id") }
	  	end

        render json: @messages, status: :ok
	end

	private

  	  def set_chat
        @application = Application.find_by(application_token: params[:application_application_token])
        @chat = @application.present? ? @application.chats.find_by(number: params[:chat_number]) : nil

	    if @chat.nil?
	      render json: { message: "not found" }, status: :not_found
	    end
      end
end
