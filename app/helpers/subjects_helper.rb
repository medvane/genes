module SubjectsHelper
  def semantic_groups(subject)
    sgrps = []
    subject.semantic_groups.split(/ /).each do |sg|
      sgrps.push(content_tag(:span, sg, :class => "semantic_group #{sg}"))
    end
    sgrps.join("").html_safe
  end
end
