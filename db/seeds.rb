terms = ["Rett Syndrome", "Autistic Disorder", "Crohn Disease", "Alzheimer Disease", "Schizophrenia", "Asthma"]
terms.each do |term|
  review = Review.create!(:title => term, :search_term => "#{term}[majr]")
  Delayed::Job.enqueue(CreateReview.new(review.id))
end