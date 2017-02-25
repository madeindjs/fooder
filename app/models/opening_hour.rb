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
    "%s: ouvert de %s à %s" % [pretty_day, self.opens.to_s(:time) , self.closes.to_s(:time) ]
  end


  def pretty_day
    DAYS.each{ |day_name|
      return day_name[0] if day_name[1] == self.day 
    }
  end

  protected
  def opens_before_closes
    errors.add(:closes, I18n.t('errors.opens_before_closes')) if opens && closes && opens >= closes
  end

  def valid_from_before_valid_through
    errors.add(:valid_through, I18n.t('errors.valid_from_before_valid_through')) if valid_from && valid_through && valid_from >= valid_through
  end

end
