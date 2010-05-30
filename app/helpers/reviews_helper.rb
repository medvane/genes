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
    link_to(link_name.html_safe, :s => name)
  end

  def sort_column?(name)
    @sort_key == name ? "sorted" : ""
  end
end
