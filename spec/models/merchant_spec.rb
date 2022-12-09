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

  it "should search for One merchant by matching name" do
    merchant_1 = Merchant.create(name: "Dre")
    merchant_2 = Merchant.create(name: "Snoop Dog")
    merchant_3 = Merchant.create(name: "Eminem ")
    merchant_4 = Merchant.create(name: "Slim Shady")
    merchant_5 = Merchant.create(name: "Marshall")

    expect(Merchant.search("m")).to eq(merchant_3)
  end
end
