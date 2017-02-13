# == Schema Information
#
# Table name: images
#
#  id                  :integer          not null, primary key
#  verse_id            :integer
#  resource_content_id :integer
#  width               :integer
#  url                 :string
#  alt                 :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Image < ApplicationRecord
  belongs_to :verse
  belongs_to :resource_content
end
