require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  it "sends a specific merchant" do
    merchant_id = create(:merchant).id

    get "/api/v1/merchants/#{merchant_id}"

    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_an(String)
    expect(merchant[:data][:type]).to be_an(String)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_an(String)
  end

  it "get all items for merchant" do
    merch_id = create(:merchant).id
    create_list(:item, 10, merchant_id: merch_id)
    get "/api/v1/merchants/#{merch_id}/items"

    items = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(items[:data].count).to eq(10)
    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end


  it "search one merchant" do
    merchant_1 = Merchant.create(name: "Dre")
    merchant_2 = Merchant.create(name: "Snoop Dog")
    merchant_3 = Merchant.create(name: "Eminem")
    merchant_4 = Merchant.create(name: "Slim Shady")
    merchant_5 = Merchant.create(name: "Marshall")

    get "/api/v1/merchants/find?name=m"

    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(merchant.count).to eq(1)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_an(String)
    expect(merchant[:data][:attributes][:name]).to eq("Eminem")
  end

end
