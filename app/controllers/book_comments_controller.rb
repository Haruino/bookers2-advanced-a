class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    # createアクション内で一時的に利用されるだけなのでローカル変数に
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = book.id
    # 上のローカル変数bookで取得したid
    @comment.save
    # redirect_to request.referer
  end
  
  def destroy
    @comment = BookComment.find(params[:id])
    @comment.destroy
    # redirect_to request.referer
  end
  
  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
