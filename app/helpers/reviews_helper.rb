module ReviewsHelper
  def review_list(reviews, title)
    if reviews.size > 0
      render 'review_list', :reviews => reviews, :title => title
    end
  end
end
