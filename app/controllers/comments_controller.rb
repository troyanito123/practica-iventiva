class CommentsController < ApplicationController

  before_action :article_set, only:[:create, :destroy]
  before_action :comment_set, only:[:destroy]
  before_action -> { authorize @comment || Comment }

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.article = @article

    if @comment.save
      flash[:success] = I18n.t 'comment_created'
      redirect_to article_path(params[:article_id])
    else
      redirect_to articles_path
    end
  end

  def destroy
    @comment.destroy
    flash[:danger] = I18n.t 'comment_deleted'
    redirect_to article_path(@article)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :article_id)
  end

  private
  def article_set
    @article = Article.find(params[:article_id])
  end

  def comment_set
    @comment = @article.comments.find(params[:id])
    puts("OBJETO COMMENT: #{@comment }")
  end
end
