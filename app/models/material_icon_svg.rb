require 'inline_svg'

class MaterialIconSvg

  # Undefined method will ref to the icon.
  def method_missing(name)
    @icon = name.to_s
    self
  end

  def reset
    @size = 24
    @icon, @cls = [nil] * 2
    self
  end

  def sizes
    {s: 18, m: 24, l: 36, xl: 48}
  end

  def size(custom_size = 24)
    @size = custom_size
    self
  end

  def cls(css_class = '')
    @cls = " #{css_class}"
    self
  end

  %w(s m l xl).each do |size|
    define_method(size) do
      @size = sizes[size.to_sym]
      self
    end
  end

  def to_s
    filename = "svg/ic_#{@icon}_24px.svg"
    transform_params = {
      class: "svgicon icon-#{@icon.dasherize}#{@cls}",
      size: "#{@size}px"
    }

    begin
      svg_file = if InlineSvg::IOResource === filename
        InlineSvg::IOResource.read filename
      else
        InlineSvg::AssetFile.named filename
      end
    rescue InlineSvg::AssetFile::FileNotFound
      return "<svg><!-- SVG file not found: '#{filename}' --></svg>".html_safe
    end

    InlineSvg::TransformPipeline.generate_html_from(svg_file, transform_params).html_safe
  end
end
