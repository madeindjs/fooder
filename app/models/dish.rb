class Dish < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :restaurant

  validates_presence_of :user_id
  validates_presence_of :category_id
  validates_presence_of :restaurant_id
  validates_presence_of :price

  mount_uploader :picture, PictureUploader

  extend FriendlyId
  friendly_id :name, use: :slugged

  ALLERGEN_VALUES = { 0 => "Non", 1 => "Traces éventuelles", 2 => "Pas de traces" }

  ALLERGENS = {
    gluten_free: "Sans gluten", 
    crustacea_free: "Sans crustacé", 
    egg_free: "Sans oeuf",
    fish_free: "Sans poisson",
    peanut_free: "Sans arachides",
    lactose_free: "Sans lactose",
    sulphite_free: "Sans sulphite"
  }
end
