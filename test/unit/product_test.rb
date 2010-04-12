require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test "save should fail validations" do
    p = Product.new
    assert !p.save, "saved invalid product"
  end

  test "product name should be unique" do
    p = Product.new
    p.name = products(:ham).name
    p.energy = products(:ham).energy
    p.category = products(:ham).category
    assert !p.save, "Saved product with not unique name"
  end

  test "water should be numeric" do
    p = products(:ham)
    p.water = "fifty"
    assert !p.valid?, "water is fifty, and the record is valid"
    p.water = 50
    assert p.valid?, "water is 50 and it is not valid"
  end

  test "protein should be numeric" do
    p = products(:ham)
    p.protein = "fifty"
    assert !p.valid?, "protein is fifty, and the record is valid"
    p.protein = 50
    assert p.valid?, "protein is 50 and it is not valid"
  end

  test "fat should be numeric" do
    p = products(:ham)
    p.fat = "fifty"
    assert !p.valid?, "fat is fifty, and the record is valid"
    p.fat = 50
    assert p.valid?, "fat is 50 and it is not valid"
  end

  test "carbohydrate should be numeric" do
    p = products(:ham)
    p.carbohydrate = "fifty"
    assert !p.valid?, "carbohydrate is fifty, and the record is valid"
    p.carbohydrate = 50
    assert p.valid?, "carbohydrate is 50 and it is not valid"
  end


  test "energy should be numeric" do
    p = products(:ham)
    p.energy = "fifty"
    assert !p.valid?, "energy is fifty, and the record is valid"
    p.energy = 50
    assert p.valid?, "energy is 50 and it is not valid"
  end

  test "energy should be present" do
    p = products(:ham)
    p.energy = nil
    assert !p.valid?, "energy is nil, and the record is valid"
  end

  test "category_id should be present" do
    p = products(:ham)
    p.category_id = nil
    assert !p.valid?, "category_id is nil, and the record is valid"
  end

  test "search by name" do
    p = Product.find_by_name(products(:ham).name)
    found_p = Product.search(products(:ham).name).first
    assert_equal p, found_p
    found_p = Product.search(products(:ham).name[2..-1]).first
    assert_equal p, found_p
  end


end

