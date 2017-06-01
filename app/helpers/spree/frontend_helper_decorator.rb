Spree::FrontendHelper.class_eval do

  def taxons_tree(root_taxon, current_taxon, max_level = 1)
    return '' if max_level < 1 || root_taxon.leaf?
    @supplier_taxons = Spree::Taxon.joins(products: {variants: :supplier_variants}).where("spree_supplier_variants.supplier_id = #{Spree::Supplier.friendly.find(session[:supplier_id]).id}").distinct
    content_tag :div, class: 'list-group' do
      taxons = root_taxon.children.map do |taxon|
        if session[:supplier_id]
          if @supplier_taxons.pluck(:id).include?(taxon.id)
            css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'list-group-item active' : 'list-group-item'
            link_to(taxon.name, seo_url(taxon), class: css_class) + taxons_tree(taxon, current_taxon, max_level - 1)
          end
        end
      end
      safe_join(taxons, "\n")
    end
  end

end