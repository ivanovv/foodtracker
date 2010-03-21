module DaysHelper

  def day_table
    collection_table(@days, :class => 'app-table') do |t|
      t.header.hide_when_empty = false
      t.header.column :enter_date, t('days.enter_date')
      t.header.column :weight, t('days.weight'), :class => "float"
      t.header.column :metabolic_norm, t('days.metabolic_norm'), :class => "float"
      t.header.column :total_calories, t('days.total_calories'), :class => "float"
      t.header.column :actions, ''

      t.rows.alternate = :odd
      t.rows.empty_caption = t('.no_days')
      t.rows.each do |row, item, index|
        row[:id] = "day-#{item.id}"
        row.enter_date  item.enter_date
        row.weight item.weight, :class => "float"
        row.metabolic_norm item.base_metabolic_rate, :class => "float"
        row.total_calories item.total_calories, :class => "float"
        row.actions table_actions(edit_day_path(item), day_path(item), item), :class => "buttons"
      end
    end
  end

end

