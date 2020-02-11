class CommentsController < ApplicationController

  before_action :article_set, only:[:create, :destroy, :edit, :update]
  before_action :comment_set, only:[:destroy, :edit, :update]
  before_action -> { authorize @comment || Comment }

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.article = @article

    if @comment.save
      flash[:success] = I18n.t 'comment_created'
      redirect_to article_path @article
    else
      redirect_to articles_path
    end
  end

  def edit
    puts("ARTICULO: #{@article}")
  end

  def update
    @comment.assign_attributes comment_params
    if @comment.save
      flash[:success] = I18n.t 'comment_updated'
      redirect_to @article
    else
      flash[:danger] = I18n.t 'comment_error'
      redirect_to @article
    end
  end

  def destroy
    @comment.destroy
    flash[:danger] = I18n.t 'comment_deleted'
    redirect_to article_path(@article)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

  private
  def article_set
    @article = Article.find(params[:article_id])
  end

  def comment_set
    @comment = Comment.find(params[:id])
  end
end
