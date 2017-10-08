class AddResultToVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :visits, :result, :string
  end
end
