require 'inline_svg'

class MaterialIconSvg

  # Undefined method will ref to the icon.
  def method_missing(name)
    @icon = name
    self
  end

  def reset
    @icon, @size = [nil] * 2
    self
  end

  def to_s
    filename = "svg/ic_#{@icon}_24px.svg"
    transform_params = {}
    begin
      svg_file = if InlineSvg::IOResource === filename
        InlineSvg::IOResource.read filename
      else
        InlineSvg::AssetFile.named filename
      end
    rescue InlineSvg::AssetFile::FileNotFound
      return "<svg><!-- SVG file not found: '#{filename}' --></svg>".html_safe
    end

    Rails.logger.debug('****')
    Rails.logger.debug(svg_file)
    InlineSvg::TransformPipeline.generate_html_from(svg_file, transform_params).html_safe
  end
end
