class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.string :person
      t.string :photo_file
      t.datetime :visit_dttm
      t.float :audio_threshold
      t.float :audio_error

      t.timestamps
    end
  end
end
