class Group < ActiveRecord::Base
	has_paper_trail

	has_many :posts, as: :postable, dependent: :destroy

	belongs_to :neighborhood
	belongs_to :apartment

	belongs_to :owner, :class_name => "User", :foreign_key => :owner_id, :inverse_of => :owned_groups
	has_many :user_groups, :dependent => :destroy
	has_many :users, :through => :user_groups
end
