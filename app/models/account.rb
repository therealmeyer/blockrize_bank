class Account < ApplicationRecord
  attr_reader :password

  validates :name, :account_num, :password_digest, presence: true
  validates :account_num, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  # before_create :create_password
  before_validation :ensure_account_num

  def self.find_by_credentials(account_num, password) 
    acc = Account.find_by(account_num: account_num)
    acc && acc.is_password?(password) ? acc : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  # def create_password
  #   self.password ||= SecureRandom.hex(4)
  # end

  private

  def ensure_account_num
    self.account_num ||= (SecureRandom.random_number(9e9) + 1e9).to_i
  end
end