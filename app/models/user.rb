class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, :session_token, :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validate :email_validation
  validates :email, uniqueness: true

  has_attached_file :picture, :styles => { :medium => "200x200>", :thumb => "100x100>" }, :default_url => "/images/:style/missing2.jpg"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  include PgSearch
  multisearchable :against => [:first_name, :last_name]

  has_many :comments, as: :commentable
  has_many(
    :authored_comments,
    class_name: "Comment",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :author
  )

  # allows other users to follow current user
  has_many :followings, as: :followable

  # returns all follow objects which belong to user
  has_many(
    :follows,
    class_name: "Follow",
    foreign_key: :follower_id,
    primary_key: :id,
    inverse_of: :follower
  )

  has_many :ratings, as: :rateable
  has_many(
    :rated_objects,
    class_name: "Rating",
    foreign_key: :rater_id,
    primary_key: :id,
    inverse_of: :rater
  )

  # gets all companies through follows relation with source type Company
  has_many(
    :followed_companies,
    through: :follows,
    source: :followable,
    source_type: "Company"
  )

  # gets all users through follows realtion with source type User
  has_many(
    :followed_users,
    through: :follows,
    source: :followable,
    source_type: "User"
  )

  def first_name
    read_attribute(:first_name).split().map(&:capitalize).join(" ")
  end

  def last_name
    read_attribute(:last_name).split().map(&:capitalize).join(" ")
  end

  def rating    
    (ratings.pluck(:rating).inject(:+) / ratings.count).to_f.round(2)
  end

  attr_reader :password
  after_initialize :ensure_session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.base64
    self.save!
    self.session_token
  end

  def self.find_by_credentials(user_params)
    user = User.find_by_email(user_params[:email])
    user.try(:is_password?, user_params[:password]) ? user : nil
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.base64
  end

  def email_validation
    unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      errors[:email] << "is not a valid email address"
    end
  end
end
