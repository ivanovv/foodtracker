module CategoriesHelper

  def category_table
    collection_table(@categories, :class => 'app-table') do |t|
      t.header.hide_when_empty = false
      t.header.column :name, t('.name'), :class => "text"
      t.header.column :actions, ''

      t.rows.alternate = :odd
      t.rows.empty_caption = t('.no_categories')
      t.rows.each do |row, category, index|
        row[:id] = "category-#{category.id}"
        row.name  category.name
        row.actions category_table_actions(category), :class => "buttons"
      end
    end
  end

  def category_table_actions(item)
    edit_url = edit_category_path(item)
    delete_url = category_path(item)

    parts = []
    parts << link_to(image_tag("edit.png"), edit_url, :title => t(".edit_hint"))
    parts << "&nbsp;"

    parts << link_to(image_tag("delete.png"), delete_url, :method => "delete",
                     :title => t(".delete_hint"),
                     :confirm => t(".confirm_for_delete", :name => item.name))

    parts.join("\n")
  end

end

