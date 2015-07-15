class Event < ActiveRecord::Base
	has_paper_trail

	has_many :posts, as: :postable, dependent: :destroy

	belongs_to :neighborhood

	belongs_to :owner, :class_name => "User", :foreign_key => :owner_id, :inverse_of => :owned_events
	has_many :user_events, :dependent => :destroy
	has_many :users, :through => :user_events

	def pending_users
		self.users.where("user_events.status = 0")
	end

	def attending_users
		self.users.where("user_events.status = 1")
	end

	def maybe_users
		self.users.where("user_events.status = 2")
	end

	def declined_users
		self.users.where("user_events.status = 3")
	end
end
