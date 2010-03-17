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
      t.header.column :name, t('.name'), :class => "text"
      t.header.column :water, t('.water'), :class => "text"
      t.header.column :protein, t('.protein'), :class => "text"
      t.header.column :fat, t('.fat'), :class => "text"
      t.header.column :carbohydrate, t('.carb'), :class => "text"
      t.header.column :energy, t('.energy'), :class => "text"
      t.header.column :actions, ''

      t.rows.alternate = :odd
      t.rows.empty_caption = t('.no_products')
      t.rows.each do |row, item, index|
        #last_login_at = item.last_login_at ? I18n.l(item.last_login_at.localtime, :format => "%e %B %Y") : "-"

        row[:id] = "product-#{item.id}"
        row.name  item.name, :class => "text"
        row.water item.water, :class => "text"
        row.protein item.protein, :class => "text"
        row.fat item.fat, :class => "text"
        row.carbohydrate item.carbohydrate, :class => "text"
        row.energy item.energy, :class => "text"

        row.actions product_table_actions(item), :class => "buttons"
      end
    end
  end

  def product_table_actions(item)
    edit_url = edit_product_path(item)
    delete_url = product_path(item)
    i_ate_this_url = new_calory_line_path(:product_id => item, :day_id =>Date.today)

    parts = []
    parts << link_to(image_tag("edit.png"), edit_url, :title => t(".edit_hint"))
    parts << "&nbsp;"

    parts << link_to(image_tag("delete.png"), delete_url, :method => "delete",
                     :title => t(".delete_hint"),
                     :confirm => t(".confirm_for_delete", :name => item.name))
    parts << "&nbsp;"

    parts << link_to(image_tag("i_ate_this_small.gif"), i_ate_this_url, :title => "I ate this")

    parts.join("\n")
  end

end

