require 'rails_helper'

RSpec.describe Item, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe 'relationships' do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    # it {should validate_presence_of(:status)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_numericality_of(:unit_price)}
  end

  it "should search for all merchants by matching name" do
    merchant_1 = Merchant.create(name: "Dre")
    item_1 = Item.create(name: "Dre", description: "throoowbaaack", unit_price: 151, merchant_id: merchant_1.id)
    item_2 = Item.create(name: "Snoop Dog", description: "throoowbaaack", unit_price: 150, merchant_id: merchant_1.id)
    item_3 = Item.create(name: "Eminem", description: "throoowbaaack", unit_price: 60, merchant_id: merchant_1.id)
    item_4 = Item.create(name: "Slim Shady", description: "throoowbaaack", unit_price: 50, merchant_id: merchant_1.id)
    item_5 = Item.create(name: "Marshall", description: "throoowbaaack", unit_price: 49, merchant_id: merchant_1.id)

    expect(Item.search_item("m")).to eq([item_3, item_5, item_4])
  end

  it "should find min item price" do
    merchant_1 = Merchant.create(name: "Dre")
    item_1 = Item.create(name: "Dre", description: "throoowbaaack", unit_price: 151, merchant_id: merchant_1.id)
    item_2 = Item.create(name: "Snoop Dog", description: "throoowbaaack", unit_price: 150, merchant_id: merchant_1.id)
    item_3 = Item.create(name: "Eminem", description: "throoowbaaack", unit_price: 60, merchant_id: merchant_1.id)
    item_4 = Item.create(name: "Slim Shady", description: "throoowbaaack", unit_price: 50, merchant_id: merchant_1.id)
    item_5 = Item.create(name: "Marshall", description: "throoowbaaack", unit_price: 49, merchant_id: merchant_1.id)

    expect(Item.find_min(50)).to eq([item_1, item_2, item_3, item_4])
  end

  it "should find max item price" do
    merchant_1 = Merchant.create(name: "Dre")
    item_1 = Item.create(name: "Dre", description: "throoowbaaack", unit_price: 151, merchant_id: merchant_1.id)
    item_2 = Item.create(name: "Snoop Dog", description: "throoowbaaack", unit_price: 150, merchant_id: merchant_1.id)
    item_3 = Item.create(name: "Eminem", description: "throoowbaaack", unit_price: 60, merchant_id: merchant_1.id)
    item_4 = Item.create(name: "Slim Shady", description: "throoowbaaack", unit_price: 50, merchant_id: merchant_1.id)
    item_5 = Item.create(name: "Marshall", description: "throoowbaaack", unit_price: 49, merchant_id: merchant_1.id)

    expect(Item.find_max(150)).to eq([item_2, item_3, item_4, item_5])
  end

  it "should find max item price" do
    merchant_1 = Merchant.create(name: "Dre")
    item_1 = Item.create(name: "Dre", description: "throoowbaaack", unit_price: 151, merchant_id: merchant_1.id)
    item_2 = Item.create(name: "Snoop Dog", description: "throoowbaaack", unit_price: 150, merchant_id: merchant_1.id)
    item_3 = Item.create(name: "Eminem", description: "throoowbaaack", unit_price: 60, merchant_id: merchant_1.id)
    item_4 = Item.create(name: "Slim Shady", description: "throoowbaaack", unit_price: 50, merchant_id: merchant_1.id)
    item_5 = Item.create(name: "Marshall", description: "throoowbaaack", unit_price: 49, merchant_id: merchant_1.id)

    expect(Item.find_max(150)).to eq([item_2, item_3, item_4, item_5])
  end

  it "should find range price " do
    merchant_1 = Merchant.create(name: "Dre")
    item_1 = Item.create(name: "Dre", description: "throoowbaaack", unit_price: 151, merchant_id: merchant_1.id)
    item_2 = Item.create(name: "Snoop Dog", description: "throoowbaaack", unit_price: 150, merchant_id: merchant_1.id)
    item_3 = Item.create(name: "Eminem", description: "throoowbaaack", unit_price: 60, merchant_id: merchant_1.id)
    item_4 = Item.create(name: "Slim Shady", description: "throoowbaaack", unit_price: 50, merchant_id: merchant_1.id)
    item_5 = Item.create(name: "Marshall", description: "throoowbaaack", unit_price: 49, merchant_id: merchant_1.id)

    expect(Item.find_range(50, 150)).to eq([item_2, item_3, item_4])
  end
end
