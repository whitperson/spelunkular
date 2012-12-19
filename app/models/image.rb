# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Image < ActiveRecord::Base
  attr_accessible :url
end
