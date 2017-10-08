class AddAgeToVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :visits, :age, :float
  end
end
