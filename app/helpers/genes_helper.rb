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

  def gene_ontologies(object, display = 5)
    go = object.class == Gene ? object.gos.group_by(&:category) : object.reviewed_gos.group_by {|g| g.go.category}
    tr = []
    td = []
    th = []
    category = {"Component" => "Cellular component", "Process" => "Biological process", "Function" => "Molecular function"}
    go.keys.sort.each do |c|
      th.push(content_tag(:th, category[c]))
      li = []
      gos = object.class == Gene ? go[c].uniq.sort_by(&:term) : go[c].uniq.sort_by(&:articles_count).reverse.shift(display)
      gos.each_index do |i|
        hide_style = i >= display ? "display: none" : nil
        term = object.class == Gene ? gos[i].term : gos[i].go.term + " [#{gos[i].articles_count}]"
        link = object.class == Gene ? gos[i].golink : gos[i].go.golink
        li.push(content_tag(:li, link_to(term, link, :target => "_blank"), :style => hide_style)) unless i >= display
      end
      toggle_link = gos.size > display ? link_to("show #{number_with_delimiter(gos.size)} more", "", :class => "button") : ""
      td.push(content_tag(:td, content_tag(:ul, li.join("\n").html_safe) + toggle_link))
    end
    tr.push(content_tag(:tr, th.join("\n").html_safe))
    tr.push(content_tag(:tr, td.join("\n").html_safe))
    table = content_tag(:table, tr.join("\n").html_safe)
  end
end
