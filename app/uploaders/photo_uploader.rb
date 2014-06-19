# encoding: utf-8

class PhotoUploader < BaseUploader

  process :resize_to_fit => [800, 600]

  version :small do
    process :resize_to_fit => [480, 360]
  end

  version :micro do
    process :resize_to_fit => [160, 120]
  end

end
