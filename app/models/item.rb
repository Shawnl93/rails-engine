class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, :description, :presence => true
  validates :unit_price, presence: :true, numericality: :true

  enum status: [:enabled, :disabled]

end
