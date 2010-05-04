require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  should_belong_to :category

  should_validate_numericality_of :water, :protein, :fat, :carbohydrate, :energy
  should_validate_uniqueness_of :name
  should_validate_presence_of :category_id, :energy
  should_ensure_value_in_range :energy, 0..700
  should_ensure_value_in_range :fat, 0..100
  should_ensure_value_in_range :protein, 0..100
  should_ensure_value_in_range :carbohydrate, 0..100
  should_ensure_value_in_range :water, 0..100


  should "new product fail validations" do
    p = Product.new
    assert !p.save, "saved invalid product"
  end

  test "search by name" do
    p = Product.find_by_name(products(:ham).name)
    found_p = Product.search(products(:ham).name).first
    assert_equal p, found_p, "found product doesn't equal to the product we searched for"
  end

  test "search by incomplete name" do
    p = Product.find_by_name(products(:ham).name)
    found_p = Product.search(products(:ham).name[2..-1]).first
    assert_equal p, found_p, "incomplete search failed"
  end

  test "search with no parameters returns all products" do
    products = Product.all
    found_products = Product.search
    assert_equal products, found_products, "products returned by search with empty parameters are not equal"
  end

  should "to_s be equal to name" do
    p = products(:ham)
    assert_equal p.to_s, p.name, "product.to_s <> product.name"
  end

end

