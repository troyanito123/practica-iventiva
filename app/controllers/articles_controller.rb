class ArticlesController < ApplicationController

  skip_before_action :logged_in_user, only: [:index, :show]
  before_action :article_set, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  before_action -> { authorize @article || Article }

  def index
    @articles = Article.all
  end

  def show
    @comments = @article.comments.order('created_at DESC')
    @images = @article.images
    @comment = Comment.new
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    @article.images = params[:article][:images]

    if @article.save
      flash[:success] = I18n.t 'article_crated'
      redirect_to articles_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @article.assign_attributes article_params
    @article.images = params[:article][:images]
    if @article.save
      flash[:success] = I18n.t 'article_updated'
      redirect_to articles_path
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = I18n.t 'article_deleted'
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  private

  def article_set
    @article = Article.find(params[:id])
  end

  private

  def handle_record_not_found
    flash[:danger] = I18n.t 'article_not_found'
    redirect_to articles_path
  end

end
