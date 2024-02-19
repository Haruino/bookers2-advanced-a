class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    # １．favorite = Favorite.new(book_id: book.id)
    # 　　book_idカラムにbookで取得したidを代入して、新しいnewインスタンスを作成
    # ２．favorite.user_id = current_user.id
    # 　　１で作成された変数favoriteに格納されたFavoriteモデルのidカラムにcurrent_userのidを代入
    favorite.save
    redirect_to request.referer
    # ユーザーがアクセスした前のページのURLを取得する = books/:id/favoriteの後にまたbooks/:idを取得する
  end
  
  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_to request.referer
  end
end
