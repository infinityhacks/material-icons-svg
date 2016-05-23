module MaterialIconsSvg
  #
  # Helper of material icons. This method return a singleton MaterialIcon class
  # to get icons in the UI.
  #
  module MaterialIconsSvgHelper
    # Singleton
    @@material_icon_svg = MaterialIconSvg.new

    #
    # Reset the previous values of the MaterialIcon class and return
    # the object to render a new icon.
    #
    # == Returns:
    # MaterialIcon instance
    #
    def material_icon_svg
      @@material_icon_svg.reset
    end

    # Typeless alias method
    alias_method :icon, :material_icon_svg
  end
end
