class AddPredictedAgeToVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :visits, :predicted_age, :float
    add_column :visits, :stated_age, :integer
    add_column :visits, :birthday_month, :integer
    add_column :visits, :birthday_year, :integer
  end
end
