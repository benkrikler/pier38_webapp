class Visit < ApplicationRecord
  mount_uploader :photo_file, ImageUploader
end
