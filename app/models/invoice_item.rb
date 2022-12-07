class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  # enum status: { pending: 0, packaged: 1, shipped: 2 }

  validates :quantity, :unit_price, :presence => true
  validates :quantity, :unit_price, :numericality => true
end
