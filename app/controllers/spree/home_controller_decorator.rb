Spree::HomeController.class_eval do

  def index
    @searcher = build_searcher(params.merge(include_images: true))
    if params[:supplier_id]
      @supplier = Spree::Supplier.find(params[:supplier_id])
      @products = @searcher.retrieve_supplier_products(@supplier)
    else
      @products = @searcher.retrieve_products
    end
    @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
    @taxonomies = Spree::Taxonomy.includes(root: :children)
  end

end