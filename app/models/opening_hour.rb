class OpeningHour < ApplicationRecord
  belongs_to :restaurant

  DAYS = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday', ]

end
