require 'rails_helper'

RSpec.describe Merchant, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe 'relationships' do
    it {should have_many(:items)}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
  end
  describe 'validations' do
    it {should validate_presence_of(:name)}
  end
end
