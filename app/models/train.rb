class Train < ApplicationRecord
  validates :number, presence: true
  has_many :reservations

  # 产生所有位置从 1A~6C
  # ["1A", "1B", "1C", "2A", "2B", "2C", "3A", "3B", "3C",
  #  "4A", "4B", "4C", "5A", "5B", "5C", "6A", "6B", "6C"]
  SEATS = []
  (1..6).each do |series|
    ["A", "B", "C"].each do |letter|
      SEATS << "#{series}#{letter}"
    end
  end

  def available_seats
    return SEATS - self.reservations.pluck(:seat_number)
  end
end
