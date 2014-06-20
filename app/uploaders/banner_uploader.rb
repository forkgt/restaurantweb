# encoding: utf-8

class BannerUploader < BaseUploader
  process :resize_to_fill => [800, 200]

  version :small do
    process :resize_to_fill => [400, 100]
  end

  version :micro do
    process :resize_to_fill => [160, 40]
  end

end
