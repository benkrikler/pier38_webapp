class Fex < ActiveRecord::Migration[5.1]
  def change
    rename_column :visits, :predicted_video_age, :predicted_iamge_age 
  end
end
