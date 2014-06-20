# encoding: utf-8

class PhotoUploader < BaseUploader

  process :resize_to_fill => [800, 400]

  version :small do
    process :resize_to_fill => [480, 240]
  end

  version :micro do
    process :resize_to_fill => [160, 80]
  end

end
