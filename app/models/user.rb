class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  has_many :user_question_feedbacks
  has_many :questions #, :source => :created_by, :foreign_key => 'created_by'
  
  before_save :encrypt_password
  
  #has_many :ratings
  #has_many :comments
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, :presence => true,
            :length   => { :maximum => 50 }

  validates :email, :presence   => true,
            :format     => { :with => email_regex },
            :uniqueness => { :case_sensitive => false }

  validates :password, :presence	=> true,
            :confirmation => true,
            :length => { :within => 6..40 }

	
  # Return true if the encrypted password matches the submitted password
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  # Used to authenticate a user with a given email and password
  def self.authenticate ( email, submitted_password)
    user = find_by_email(email)
    user && user.has_password?(submitted_password) ? user : nil
  end

  # Given an id and salt, compare them with the database
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  # find or create a feedback relationship
  def feedback(question)
    user_question_feedbacks.find_by_question_id(question) || user_question_feedbacks.create!(:question_id => question.id)
  end

  private
    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(str)
      secure_hash("#{salt}--#{str}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(str)
      Digest::SHA2.hexdigest(str)
    end
end
