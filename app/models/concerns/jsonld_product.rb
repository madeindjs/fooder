module JsonldProduct
  # Transform this object into an hash compatible to JSON-LD format
  #
  # @return [Hash]
  def to_jsonld
    logo = ApplicationController.helpers.image_url(self.picture, host: 'fooder.pro')
    return {
      "@context" => "http://schema.org/",
      "@type": "Product",
      name: self.name,
      brand: self.restaurant.to_jsonld,
      logo: logo,
      image: logo,
    }
  end
end
