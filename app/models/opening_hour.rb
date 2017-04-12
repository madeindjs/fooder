class OpeningHour < ApplicationRecord

  belongs_to :restaurant

  validates_presence_of :day, :closes, :opens, :restaurant_id
  validates_inclusion_of :day, :in => 1..7
  validate :opens_before_closes 
  validate :valid_from_before_valid_through 

  # sample validation for better user feedback
  validates_uniqueness_of :opens, scope: [:restaurant_id, :day]
  validates_uniqueness_of :closes, scope: [:restaurant_id, :day]


  DAYS = [ ['Lundi', 1], ['Mardi', 2], ['Mercredi', 3], ['Jeudi', 4], ['Vendredi', 5], ['Samedi', 6], ['Dimanche', 7]]

  def to_s
    "%s: ouvert %s" % [pretty_day, pretty_hours ]
  end


  def pretty_hours
    "%s à %s" % [self.opens.to_s(:time) , self.closes.to_s(:time)]
  end


  def pretty_day
    DAYS.each{ |day_name|
      return day_name[0] if day_name[1] == self.day 
    }
  end

  # Check if this opening hour is actually valid or not
  def actual?
    if valid_from || valid_through
      now = DateTime.now
      (!valid_from || (valid_from < now)) && (!valid_through || (valid_through > now))
    else
      true
    end
  end

  protected
  def opens_before_closes
    errors.add(:closes, "Opening time can't be after closed time") if opens && closes && opens >= closes
  end

  def valid_from_before_valid_through
    errors.add(:valid_through, "Valif From can't be after Valid Throught") if valid_from && valid_through && valid_from >= valid_through
  end

end
