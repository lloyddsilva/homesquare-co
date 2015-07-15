class User < ActiveRecord::Base
  rolify
  has_paper_trail
  acts_as_liker
  acts_as_messageable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  has_many :user_apartments, :dependent => :destroy
  has_many :apartments, :through => :user_apartments

  has_many :owned_events, :class_name => "Event", :foreign_key => :owner_id, :inverse_of => :owner, :dependent => :destroy
  has_many :user_events, :dependent => :destroy
  has_many :events, :through => :user_events

  has_many :owned_groups, :class_name => "Group", :foreign_key => :owner_id, :inverse_of => :owner, :dependent => :destroy
  has_many :user_groups, :dependent => :destroy
  has_many :groups, :through => :user_groups

  has_many :posts, as: :postable, dependent: :destroy
  has_many :comments, dependent: :destroy

  ## PAPERCLIP
  has_attached_file :avatar, 
  :styles => { :large => "140x140>", :medium => "100x100>", :small => "45x45>", :thumb => "29x29>" }, 
  :default_url => "/images/:style/missing.png",
  :storage => :s3

  validates_attachment_content_type :avatar, :content_type => /\Aimage/

    ## CONSTANTS
    # sets the standard regular expressions for verification
    NAME_REGEX = /\A[a-z\x20.']+\z/i
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    GENDERS = ['Male', 'Female']


     ## VALIDATIONS

     validates :first_name,  :presence => true, :format => { :with => NAME_REGEX, :message => "^First name contains invalid characters." }, :length => { :maximum => 30 }

     validates :last_name,  :presence => true, :format => { :with => NAME_REGEX, :message => "^Last name contains invalid characters." }, :length => { :maximum => 30 }

     validates :email, :presence => true, :length => { :maximum => 250 }, :format => {  :with => EMAIL_REGEX, :message => "^The e-mail address you provided is invalid"}, :uniqueness => { :case_sensitive => false, :message => "^There is already an account associated with this email" }

     validates_acceptance_of :terms_of_service, message: '^Please accept the terms of service and privacy policy', :allow_nil => false, :on => :create

     after_create :ensure_at_least_one_admin

     def slug_candidates
      [
        [:first_name, :last_name],
        [:first_name, :last_name, :slug_sequence]
      ]
    end

    def should_generate_new_friendly_id?
     slug.blank?
   end

   def slug_sequence
    slug_canditate = [normalize_friendly_id(first_name), normalize_friendly_id(last_name)].reject(&:empty?).join('-')
    slug_sequence = User.where("slug like '#{slug_canditate}%'").count + 1
  end

    ## HELPERS

    def full_name 
      first_name + " " + last_name
    end

    def name
      full_name
    end

    def mailboxer_email(object)
      return email
    end

    # We never want an app without an admin so let's ensure there is at least one user
    def ensure_at_least_one_admin
      if User.count == 1
        u = User.first
        u.add_role :admin
        u.save!
      end
    end


    ## OMNIAUTH FACEBOOK

    def self.find_for_facebook_oauth(auth, apartment_id = '')
      logger.debug "DEBUG::#{auth}"
      logger.debug "DEBUG::#{auth.info.email}"

      if user = User.find_by_email(auth.info.email)
        user.provider = auth.provider
        user.uid = auth.uid
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.avatar = open(auth.info.image, :allow_redirections => :safe) if auth.info.image?
        logger.debug "DEBUG::#{user}"
        user
      else
        where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
          user.provider = auth.provider
          user.uid = auth.uid
          user.email = auth.info.email
          user.password = Devise.friendly_token[0,20]
          user.first_name = auth.info.first_name
          user.last_name = auth.info.last_name
          user.avatar = open(auth.info.image, :allow_redirections => :safe) if auth.info.image?
          user.terms_of_service = "1"
          if !apartment_id.blank?
            logger.debug "DEBUG::#{apartment_id}"
            user.apartments << Apartment.find_by_id(apartment_id)
          end
          user.save!
        end
      end
    end

    def self.new_with_session(params, session)
      logger.debug "DEBUG::#{session}"
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
         user.email = data["email"] if user.email.blank?
       end
       if data = session["apartment_id"]
        user.apartments << Apartment.find_by_id(data)
      end
    end
  end

  private

  def process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
  end

end
