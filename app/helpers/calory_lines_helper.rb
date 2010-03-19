module CaloryLinesHelper

  def calory_line_table
    collection_table(@calory_lines, :class => 'app-table') do |t|
      t.header.hide_when_empty = false
      t.header.column :day, t('calory_lines.day'), :class => "text"
      t.header.column :product, t('calory_lines.product'), :class => "text"
      t.header.column :net_weight, t('calory_lines.net_weight'), :class => "text"
      t.header.column :energy, t('calory_lines.energy'), :class => "text"
      t.header.column :total_calories, t('calory_lines.total_calories'), :class => "text"

      t.header.column :actions, ''

      t.rows.alternate = :odd
      t.rows.empty_caption = t('.no_calory_lines')
      t.rows.each do |row, item, index|
        row[:id] = "calory_line-#{item.id}"
        row.day  item.day.enter_date.to_s
        row.product item.product.name
        row.net_weight item.net_weight
        row.energy item.energy
        row.total_calories item.total_calories
        delete_url = @day ? day_calory_line_path(@day, item) : calory_line_path(item)
        logger.debug delete_url
        edit_url = @day ? edit_day_calory_line_path(@day, item) :  edit_calory_line_path(item)

        row.actions table_actions(edit_url, delete_url, item), :class => "buttons"
      end
    end
  end

end

