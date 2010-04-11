require 'test_helper'

class CategoryTest < ActiveSupport::TestCase


  test "should not allow categories without name" do
    cat = Category.new
    assert !cat.save, "Saved category w/o name"
  end

  test "category name should be unique" do
    cat = Category.new
    cat.name = categories(:meat).name
    assert !cat.save, "Saved category with the existing name"
  end

  test "to_s equals name" do
    cat = categories(:meat)
    assert_equal cat.to_s, cat.name, "category.to_s isn't equal to category.name"
  end

  test "search by product name" do
    categories = Category.search_by_product_name(products(:ham).name)
    assert categories.size > 0, "No categories found"
    assert categories.size == 1, "Several categories found"
    category = Category.find(categories(:meat).id)
    assert_equal categories[0], category, "Found category differs"
  end

end

