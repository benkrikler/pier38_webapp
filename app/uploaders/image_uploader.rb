class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "images/#{model.class.to_s.pluralize.underscore}/#{mounted_as}/#{model.id}"
  end

  version :medium do
    process resize_to_fill: [200, 200]
  end

  version :small, from_version: :medium do
    process resize_to_fill: [100, 100]
  end

  version :thumb, from_version: :small do
    process resize_to_fill: [20, 20]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
