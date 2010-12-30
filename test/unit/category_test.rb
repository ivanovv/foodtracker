require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  should have_many :products

  should validate_uniqueness_of :name
  should validate_presence_of :name

  should "to_s be equal to name" do
    cat = categories(:meat)
    assert_equal cat.to_s, cat.name, "category.to_s isn't equal to category.name"
  end

  should "search by product name" do
    categories = Category.search_by_product_name(products(:ham).name)
    assert categories.size > 0, "No categories found"
    assert categories.size == 1, "Several categories found"
    category = Category.find(categories(:meat).id)
    assert_equal categories[0], category, "Found category differs"
  end

  should "have scope by_name" do
    should_have_named_scope :by_name, :order => "name ASC"
  end

end

