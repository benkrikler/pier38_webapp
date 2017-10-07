class Fiximg < ActiveRecord::Migration[5.1]
  def change
    rename_column :visits, :predicted_iamge_age, :predicted_image_age 
  end
end
