class ArticlesController < ApplicationController
  before_action :get_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :check_query, only: :index

  def index
    @articles = Article.order(created_at: :desc).paginate(page: params[:page], per_page: 8)
  end

  def search
    @articles = Article.fulltext_search(params[:q]).paginate(page: params[:pgae], per_page: 8)
    render :index
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Sweet! Created a new article!!"
      redirect_to @article
    else
      flash[:danger] = "Something went wrong..."
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      flash[:success] = "Nice! Updated the article successfully"
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url
  end

  private 

    def get_article
      @article = Article.friendly.find(params[:id])
    end

    def article_params 
      params.require(:article).permit(:title, :content, :keywords, :slug)
    end

    def check_query
      if params[:q].present?
        redirect_to search_articles_url(q: params[:q])
      end
    end

end
