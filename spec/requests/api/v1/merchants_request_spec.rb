require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)

      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_an(String)
    end
  end

  it "sends a specific merchant" do
    merchant_id = create(:merchant).id

    get "/api/v1/merchants/#{merchant_id}"

    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq(merchant_id)
    expect(merchant[:id]).to be_an(Integer)

    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_an(String)
  end

  it "get a specific item for merchant" do
    merchant_id = create(:merchant).id
    create_list(:item, 10)

    get "/api/v1/merchants/#{merchant_id}/items"

    items = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(items.count).to eq(10)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)

      expect(item).to have_key(:name)
      expect(item[:name]).to be_an(String)

      expect(item).to have_key(:description)
      expect(item[:description]).to be_an(String)

      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_an(Float)

      expect(item).to have_key(:merchant_id)
      expect(item[:merchant_id]).to be_an(Integer)
    end
  end
end
