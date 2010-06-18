module GenesHelper
  def species_tab2
    current_id = params[:t]
    li = [content_tag(:li, link_to("All species: #{number_with_delimiter(Gene.count)}", base_params(:t, nil)), :class => "#{params[:t].blank? ? "current" : nil}")]
    Taxonomy.order("taxonomies.genes_count desc").where(:id => [9606, 10090, 10116, 7227]).each do |taxonomy|
      name = truncate(taxonomy.scientific_name, :length => 18)
      genes = number_with_delimiter(taxonomy.genes_count)
      li_class = (params[:t].present? and params[:t].to_i == taxonomy.id) ? "current" : nil
      li.push(content_tag(:li, link_to("#{name}: #{genes}", base_params(:t, taxonomy.id)), :class => li_class))
    end    
    ul = content_tag(:ul, li.join("\n").html_safe)
    content_tag(:div, ul.html_safe, :id => "species_tab")
  end
end
