class AddUuidToVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :visits, :uuid, :string
    add_column :visits, :nationality, :string
    add_column :visits, :gender, :string
    add_column :visits, :parent_origin, :string
  end
end
