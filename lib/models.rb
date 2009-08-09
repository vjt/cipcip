class User < ActiveRecord::Base
  establish_connection $db['authentication']
  set_table_name 'mailbox'
  set_primary_key 'username'

  has_many :tweets, :foreign_key => :user

  acts_as_authentic do |c|
    c.logged_in_timeout 1.day
  end

  def valid_password?(password)
    Authlogic::CryptoProviders::MD5Crypt.matches?(self.password, password)
  end
end

class UserSession < Authlogic::Session::Base
end

class Tweet < ActiveRecord::Base
  belongs_to :user, :foreign_key => :user
  validates_presence_of :user
  validates_presence_of :body
  named_scope :by_date, :order => 'tweets.created_at DESC'
end
