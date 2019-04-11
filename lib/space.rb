require 'data_mapper'
require 'dm-types'

class Space
  include DataMapper::Resource

  property :id,          Serial
  property :name,        String,     :required => true
  property :description, Text,       :required => true, lazy: false
  property :price,       Integer,    :required => true
  property :start_date,  Date,       :required => true
  property :end_date,    Date,       :required => true

  belongs_to :user

  def self.filter_spaces(start_date, end_date)
    start_date = start_date.nil? ? Date.new(1900, 01, 01) : Date.strptime(start_date, "%Y-%m-%d")
    end_date = end_date.nil? ? Date.new(2200, 01, 01) : Date.strptime(end_date, "%Y-%m-%d")
    spaces = Space.all
    filtered_spaces = []
    spaces.each do |space|
      if space.start_date > end_date || space.end_date < start_date
      else
        filtered_spaces << space
      end
    end
    return filtered_spaces
  end
end
