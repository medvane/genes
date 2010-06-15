module ReviewsHelper
  def review_list(reviews, title)
    if reviews.size > 0
      render 'review_list', :reviews => reviews, :title => title
    end
  end

  def sort_heading(name)
    # up triangle: &#x25B2;
    # down triangle; &#x25BC;
    link_name = name.titleize
    link_name += " &#x25BC;" if @sort_key == name
    link_to(link_name.html_safe, base_params(:s, name))
  end

  def sort_column?(name)
    @sort_key == name ? "sorted" : ""
  end

  def species_tab(review)
    species = review.reviewed_genes.group(:taxonomy_id).order("count_gene_id desc").count(:gene_id)
    current_id = params[:t]
    li = [content_tag(:li, link_to("All species: #{number_with_delimiter(review.genes_count)}", base_params(:t, nil)), :class => "#{params[:t].blank? ? "current" : nil}")]
    taxonomy_ids = species.keys
    taxonomy_ids.each do |taxonomy_id|
      name = truncate(Taxonomy.find(taxonomy_id).scientific_name, :length => 18)
      genes = number_with_delimiter(species[taxonomy_id])
      li_class = (params[:t].present? and params[:t].to_i == taxonomy_id) ? "current" : nil
      li_style = taxonomy_ids.rindex(taxonomy_id) > 4 ? "display: none" : nil
      li.push(content_tag(:li, link_to("#{name}: #{genes}", base_params(:t, taxonomy_id)), :class => li_class, :style => li_style))
    end    
    ul = content_tag(:ul, li.join("\n").html_safe)
    content_tag(:div, ul.html_safe, :id => "species_tab")
  end
end
