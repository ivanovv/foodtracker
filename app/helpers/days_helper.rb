module DaysHelper

  def day_table
    collection_table(@days, :class => 'app-table') do |t|
      t.header.hide_when_empty = false
      t.header.column :enter_date, t('days.enter_date')
      t.header.column :weight, t('days.weight'), :class => "float"
      t.header.column :metabolic_norm, t('days.metabolic_norm'), :class => "float"
      t.header.column :total_calories, t('days.total_calories'), :class => "float"
      t.header.column :to_eat, t('days.to_eat'), :class => "float"
      t.header.column :actions, ''

      t.rows.alternate = :odd
      t.rows.empty_caption = t('.no_days')
      t.rows.each do |row, item, index|
        row[:id] = "day-#{item.id}"
        row.enter_date  link_to(item.to_s, day_calory_lines_path(item))
        row[:onclick] = "location.href =  '#{day_calory_lines_path(item)}'"
        row.weight item.weight, :class => "float"
        row.metabolic_norm item.base_metabolic_rate, :class => "float"
        row.total_calories item.total_calories, :class => "float"
        row.to_eat item.to_eat, :class => "float"
        row.actions table_actions(edit_day_path(item), day_path(item), item), :class => "buttons"
      end
    end
  end

#  def day_calender(all_days)
#    s = ''
#    calendar_for(all_days, :today => Date.today) do |t|
#      s << t.head('mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun')
#      t.day(:day_method => :enter_date) do |day, days|
#        s << day.day
#        days.each do |d|
#          s << d.total_calories.to_s
#        end
#      end
#    end
#    s
#  end

end

