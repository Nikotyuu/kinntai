require 'csv'

CSV.generate do |csv|
  csv_column_names = %w(name email created_at)
  csv << csv_column_names
  @users.pluck(*csv_column_names).each do |user|
    csv << user
  end
end