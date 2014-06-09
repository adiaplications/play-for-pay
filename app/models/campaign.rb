class Campaign < ActiveRecord::Base

  has_many :ads

  validates_presence_of :name
  validates_presence_of :image_url
  validates_presence_of :package_name

  scope :active, lambda { where(:active => true) }
  scope :disactive, lambda { where(:active=> false) }
  scope :sorted, lambda { order("campaigns.name ASC") }

end
