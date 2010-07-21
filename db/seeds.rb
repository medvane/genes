terms = ["Amyotrophic Lateral Sclerosis", "Alzheimer Disease", "Asthma", "Autistic Disorder", "Cancer/genetics", "Crohn Disease", "Inflammatory Bowel Diseases", "Mental Disorders/genetics", "Multiple Sclerosis", "Systemic Lupus Erythematosus", "Sjogren's Syndrome", "Myocardial Infarction", "Neoplasm Metastasis", "HIV"]
terms.each do |term|
  review = Review.create!(:title => term, :search_term => "#{term}[majr]")
  Delayed::Job.enqueue(CreateReview.new(review.id))
end
