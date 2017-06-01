Spree::HomeController.class_eval do

  def index
    @searcher = build_searcher(params.merge(include_images: true))
    if params[:id]
      params[:q] ||= {}
      params[:q][:meta_sort] ||= "name.asc"
      session[:supplier_id] = params[:id]
      @supplier = Spree::Supplier.friendly.find(params[:id])
      @products = @searcher.retrieve_supplier_products(@supplier)
      @search = @products.search(params[:q])
      @products = @search.result
    else
      @products = @searcher.retrieve_products
    end
    @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
    @taxonomies = Spree::Taxonomy.includes(root: :children)
  end

end