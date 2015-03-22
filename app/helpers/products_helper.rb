module ProductsHelper

  def product_image_class(product)
    product.default_image ? "background-image:url(#{product.default_image.path})" : ''
  end
end