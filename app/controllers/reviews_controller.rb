class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
    @review = Review.new
  end

  def show
    @review = Review.find(params[:id])
    @reviewed_genes = @review.reviewed_genes.limit(@per_page).offset(@offset)
    @last_item = @review.genes_count
  end

  def new
    @review = Review.new
  end

  def edit
    @review = Review.find(params[:id])
  end

  def create
    @review = Review.new(params[:review])
    webenv, count = Pgene::Eutils.esearch(@review.search_term)
    pmid = Pgene::Eutils.efetch(webenv)
    @review.search_results_count = count
    pg = PublishedGene.where(:article_id => pmid)
    @review.articles_count = pg.map {|p| p.article_id}.uniq.count
    pgg = pg.group_by(&:gene_id)
    @review.genes_count = pgg.keys.size
    
    respond_to do |format|
      if @review.save
        pgg.sort {|a, b| pgg[b[0]].size <=> pgg[a[0]].size}.each do |g|
          rg = @review.reviewed_genes.new
          rg.gene_id = g[0]
          rg.articles_count = g[1].size
          rg.article_id_list = g[1].map {|a| a.article_id}
          rg.save
        end
        format.html { redirect_to(@review, :notice => 'Review was successfully created.') }
        format.xml  { render :xml => @review, :status => :created, :location => @review }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to(@review, :notice => 'Review was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to(reviews_url) }
      format.xml  { head :ok }
    end
  end
end
