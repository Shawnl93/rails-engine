require "rails_helper"

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 10)

    get "/api/v1/items"

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

  it "sends a specific item" do
    item_id = create(:item).id

    get "/api/v1/items/#{item_id}"

    item = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to eq("#{item_id}")
    expect(item[:data][:id]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_an(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
  end

  it "can create a new item" do
    merchant_idd = create(:merchant).id
    item_params = ({
        name: "Phone",
        description: "It calls people",
        unit_price: 1000.01,
        merchant_id: merchant_idd
      })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "it can update an existing item" do
    item_id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Laptop"}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{item_id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: item_id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Laptop")
  end

  it "it can desroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    expect{ delete "/api/v1/items/#{item.id}"}.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "show merchant info from item id" do

    merch_id = create(:merchant).id
    item_id = create(:item, merchant_id: merch_id).id

    get "/api/v1/items/#{item_id}/merchant"

    merch_id = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(merch_id.count).to eq(1)
    expect(merch_id[:data]).to have_key(:id)

    expect(merch_id[:data]).to have_key(:type)
    expect(merch_id[:data][:type]).to be_an(String)
    expect(merch_id[:data][:attributes]).to have_key(:name)
    expect(merch_id[:data][:attributes][:name]).to be_an(String)


  end

end
