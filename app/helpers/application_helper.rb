module ApplicationHelper
  def pagination
    prev_offset = @offset - @per_page
    prev_offset = nil if prev_offset <= 0
    next_offset = @offset + @per_page
    pagination = []
    pagination.push(link_to("Beginning", pagination_params(nil))) if @offset > 0
    pagination.push(link_to("Previous #{@per_page}", pagination_params(prev_offset))) if @offset > @per_page
    pagination.push(link_to("Next #{@per_page}", pagination_params(next_offset))) if @last_item.nil? or next_offset < @last_item
    content_tag(:div, pagination.join("\n").html_safe, :class => "pagination")
  end

  def pagination_params(offset)
    p = { :o => offset }
    p[:q] = params[:q] if params[:q].present?
    p[:s] = params[:s] if params[:s].present?
    p[:t] = params[:t] if params[:t].present?
    return p
  end

  def help(text)
    content_tag(:span, "[?]", :title => text, :class => "help")
  end
end
