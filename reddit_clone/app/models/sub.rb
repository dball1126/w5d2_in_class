# == Schema Information
#
# Table name: subs
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  description :text             not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ApplicationRecord
    validates :title, :description, presence: true

    has_many :taggings, dependent: :destroy, inverse_of: :sub
    has_many :posts, through: :taggings, source: :post
    belongs_to :user
end
