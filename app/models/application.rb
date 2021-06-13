class Application < ApplicationRecord
	has_many :chats

	def increment_chats_count
		self.lock!
		self.chats_count += 1
		self.chats_inc += 1
		self.save
	end

	def as_json(options={})
	  options[:except] ||= [:id, :chats_inc]
	  super
	end 
end
