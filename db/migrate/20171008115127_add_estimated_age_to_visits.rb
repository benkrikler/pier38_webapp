class AddEstimatedAgeToVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :visits, :estimated_age, :integer
  end
end
