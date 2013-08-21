class ImagesController < ApplicationController
  layout false

  DEFAULT_BACKGROUND_COLOR = 'black'

  def show
    send_data image.to_blob, type: image.mime_type, disposition: :inline
  end

  protected

  def image
    @image ||= begin
      Magick::Image.new(width, height).tap do |image|
        image.format           = format
        image.background_color = background_color
        image.erase!
      end
    end
  end

  def width
    params.require(:width).to_i
  end

  def height
    params.require(:height).to_i
  end

  def format
    params.require(:format).downcase
  end

  def background_color
    params[:background_color] || DEFAULT_BACKGROUND_COLOR
  end
end
