class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new
    to = Time.current.at_end_of_day
    # Time.current はconfig/application.rbに設定してあるタイムゾーンを元に現在日時を取得,
    # at_end_of_day は1日の終わりを23:59に設定
    from = (to - 6.day).at_beginning_of_day
    # to - 6.day という計算は、現在の日時から6日引いた日時
    # at_beginning_of_dayは1日の始まりの時刻を0:00に設定し

    # つまり今日が29日なら、23日の0：00から29日の23：59までを対象にする

     @books = Book.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).where(created_at: from...to).size
      }.reverse
    # @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
