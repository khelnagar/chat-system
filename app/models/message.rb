class Message < ApplicationRecord
  belongs_to :chat

  validates :chat_id, uniqueness: { scope: :number }

  include Searchable
  
  Message.import force: true # for auto sync model with elastic search

  def as_json(options={})
	options[:except] ||= [:id, :chat_id]
    super
  end
end