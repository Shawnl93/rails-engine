class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, :description, :presence => true
  validates :unit_price, presence: :true, numericality: :true

  enum status: [:enabled, :disabled]

  def self.search_item(name)
    self.order(:name).where("name iLIKE?", "%#{name}%")
  end

  def self.find_min(min)
    self.order(unit_price: :desc).where("unit_price >= ?", min)
  end

  def self.find_max(max)
    self.order(unit_price: :desc).where("unit_price <= ?", max)
  end

  def self.find_range(min, max)
    where("unit_price >= #{min} AND unit_price <= #{max}")
  end

end
