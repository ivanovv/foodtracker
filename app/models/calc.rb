class Calc < ActiveRecord::Base
  
  def self.columns() @columns ||= []; end;
    
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type, null)
  end
    
  column :weight, :integer
  
  validates_presence_of :weight
  validates_numericality_of :weight
end