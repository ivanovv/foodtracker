module ProductsHelper

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end

  def product_table(products = @products)
    collection_table(products, :class => 'app-table') do |t|
      t.header.hide_when_empty = false
      t.header.column :name, t('.name')
      t.header.column :water, t('.water'), :class => "float"
      t.header.column :protein, t('.protein'), :class => "float"
      t.header.column :fat, t('.fat'), :class => "float"
      t.header.column :carbohydrate, t('.carb'), :class => "float"
      t.header.column :energy, t('.energy'), :class => "float"
      t.header.column :actions, ''

      t.rows.alternate = :odd
      t.rows.empty_caption = t('.no_products')
      t.rows.each do |row, item, index|

        row[:id] = "product-#{item.id}"
        row.name  item.name
        row.water item.water, :class => "float"
        row.protein item.protein, :class => "float"
        row.fat item.fat, :class => "float"
        row.carbohydrate item.carbohydrate, :class => "float"
        row.energy item.energy, :class => "float"

        row.actions product_table_actions(item), :class => "buttons"
      end
    end
  end

  def product_table_actions(item)
    edit_url = edit_product_path(item)
    delete_url = product_path(item)
    i_ate_this_url = new_day_calory_line_path(:product_id => item, :day_id =>params[:day_id] || Date.today)

    parts = []
    parts << table_actions(edit_url, delete_url, item)
    parts << link_to(image_tag("i_ate_this_small.gif"), i_ate_this_url, :title => "I ate this")

    parts.join("\n")
  end

end

