# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  last_name           :string(255)
#  balance             :integer          default(0)
#  nickname            :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  encrypted_password  :string(255)      default(""), not null
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :string(255)
#  last_sign_in_ip     :string(255)
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable

  has_many :orders, -> { includes :products }

  validates :nickname, presence: true, uniqueness: true
  validates :name, presence: true
  validates :last_name, presence: true
  validates :password, length: { in: 8..128 }, confirmation: true

  def full_name
    "#{name} #{last_name}"
  end

  def pay(amount)
    self.increment!(:balance, - amount)
  end
end
