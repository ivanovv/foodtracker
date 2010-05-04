module CaloryLinesHelper

  def calory_line_table
    collection_table(@calory_lines, :class => 'app-table') do |t|
      t.header.hide_when_empty = false
      t.header.column :day, t('calory_lines.day')
      t.header.column :product, t('calory_lines.product')
      t.header.column :net_weight, t('calory_lines.net_weight'), :class => "float"
      t.header.column :energy, t('calory_lines.energy'), :class => "float"
      t.header.column :total_calories, t('calory_lines.total_calories'), :class => "float"

      t.header.column :actions, ''

      t.rows.alternate = :odd
      t.rows.empty_caption = t('.no_calory_lines')
      t.rows.each do |row, item, index|
        row[:id] = "calory_line-#{item.id}"
        row.day  item.day.to_s
        row.product item.product.name
        row.net_weight item.net_weight, :class => "float"
        row.energy item.energy, :class => "float"
        row.total_calories item.total_calories, :class => "float"
        delete_url = @day ? day_calory_line_path(@day, item) : calory_line_path(item)
        edit_url = @day ? edit_day_calory_line_path(@day, item) :  edit_calory_line_path(item)

        row.actions table_actions(edit_url, delete_url, item), :class => "buttons"
      end
      t.footer :name, t('calory_lines.total_calories_footer'), :class => "name"
      t.footer :total_calories, @total_calories, :class => "value"
    end
  end

end

