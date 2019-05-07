# == Schema Information
#
# Table name: posts
#
#  id      :bigint           not null, primary key
#  title   :string           not null
#  url     :string
#  content :text
#  sub_id  :integer          not null
#  user_id :integer          not null
#

class Post < ApplicationRecord
    validates :title, presence: true

    has_many :taggings, dependent: :destroy, inverse_of: :post
    has_many :subs, through: :taggings, source: :sub
    belongs_to :user  
    
end
