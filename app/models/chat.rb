class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages

  validates :application_id, uniqueness: { scope: :number }

  def increment_messages_count
  	self.lock!
    self.messages_count += 1
    self.messages_inc += 1
  	self.save
  end

  def as_json(options={})
	  options[:except] ||= [:id, :application_id, :messages_inc]
    super
  end
end
