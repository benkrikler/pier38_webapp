class AddHearingImpairedToVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :visits, :hearing_impaired, :boolean, default: false
    remove_column :visits, :parent_origin
    add_column :visits, :mother_origin, :string
    add_column :visits, :father_origin, :string 
  end
end
