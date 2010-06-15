module ApplicationHelper
  def pagination
    prev_offset = @offset - @per_page
    prev_offset = nil if prev_offset <= 0
    next_offset = @offset + @per_page
    pagination = []
    pagination.push(link_to("Beginning", base_params(:o, nil))) if @offset > 0
    pagination.push(link_to("Previous #{@per_page}", base_params(:o, prev_offset))) if @offset > @per_page
    pagination.push(link_to("Next #{@per_page}", base_params(:o, next_offset))) if @last_item.nil? or next_offset < @last_item
    content_tag(:div, pagination.join("\n").html_safe, :class => "pagination")
  end

  def base_params(key, val)
    p = {}
    p[:q] = params[:q] if params[:q].present?
    p[:s] = params[:s] if params[:s].present?
    p[:t] = params[:t] if params[:t].present?
    p[key] = val
    return p
  end

  def help(text)
    content_tag(:span, "[?]", :title => text, :class => "help")
  end
end
