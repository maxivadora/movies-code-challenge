# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_secure_password
  
  validates :email, uniqueness: true
  
  before_validation :downcase_email

  private
  def downcase_email
    self.email = email.downcase if email.present?
  end
end