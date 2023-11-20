# spec/models/item_spec.rb
require 'rails_helper'

RSpec.describe Item, type: :model do
  it "soft deletes an item" do
    item = Item.create(name: "Test Item")
    item.soft_delete

    expect(item.deleted_at).to_not be_nil
  end

  it "restores a soft-deleted item" do
    item = Item.create(name: "Test Item")
    item.soft_delete
    item.restore

    expect(item.deleted_at).to be_nil
  end

  it "excludes soft-deleted items from normal queries" do
    item1 = Item.create(name: "Item 1")
    item2 = Item.create(name: "Item 2")

    item1.soft_delete

    expect(Item.all).to eq([item2])
  end
end
