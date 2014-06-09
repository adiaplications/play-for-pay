class Ad < ActiveRecord::Base

  belongs_to :campaign

  validates_presence_of :price
  validates_presence_of :link_url

  scope :get_by_country, lambda {|query|
    where (["country LIKE ?", "#{query}"])
  }

  scope :sorted, lambda { order("ads.price DESC") }
end
