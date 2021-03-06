module CategoriesHelper

  def category_table
    collection_table(@categories, :class => 'app-table') do |t|
      t.header.hide_when_empty = false
      t.header.column :name, t('categories.name')
      t.header.column :actions, ''

      t.rows.alternate = :odd
      t.rows.empty_caption = t('.no_categories')
      t.rows.each do |row, item, index|
        row[:id] = "category-#{item.id}"
        row[:onclick] = "location.href =  '#{category_products_path(item)}'"
        row.name  link_to item.name, category_products_path(item)
        row.actions table_actions(edit_category_path(item), category_path(item), item), :class => "buttons"
      end
    end
  end
end

