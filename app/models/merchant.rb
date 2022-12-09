class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  enum status: [:enabled, :disabled]

  validates_presence_of :name

  def self.search(name)
    self.order(:name).where("name iLIKE?", "%#{name}%").first
  end

end
