class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.article = Article.find(params[:article_id])

    if @comment.save
      redirect_to article_path(params[:article_id])
    else
      redirect_to articles_path
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :article_id)
  end
end
