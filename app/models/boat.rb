class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.limit(5).order("id asc")
  end

  def self.dinghy
    self.where('length < 20')
  end

  def self.ship
    self.where('length > 20')
  end

  def self.last_three_alphabetically
    self.limit(3).order("name desc")
  end

  def self.without_a_captain
    self.where("captain_id IS NULL")
  end

  def self.sailboats
    self.joins(:classifications).where(classifications: { name: "Sailboat" })
  end

  def self.with_three_classifications
    self.joins(:boat_classifications).group(:boat_id).having("count(boat_id) IS ?", 3)
  end

  def self.motorboats
    self.joins(:classifications).where(classifications: { name: "Motorboat" })
  end

  def self.longest_boat
    self.limit(1).order("length desc")
  end
end
