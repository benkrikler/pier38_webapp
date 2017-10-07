class AddPredictedAgeAudioToVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :visits, :predicted_audio_age, :float
    rename_column :visits, :predicted_age, :predicted_video_age 
  end
end
