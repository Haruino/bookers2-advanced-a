class SearchesController < ApplicationController
  before_action :authenticate_user!
  def search
    @range = params[:range]
    @word = params[:word]
    
    if @range == "User" 
       @users = User.looks(params[:search], params[:word])
      # looksメソッドを使い、検索内容を取得し、インスタンス変数に代入
      # インスタンス変数はinedxのループで使用される
      render "/searches/search_result"
    else
       @books = Book.looks(params[:search], params[:word])
       render "/searches/search_result"
    end  
  end
  
  # 検索フォームからの情報を受け取る
  # 検索モデル→params[:range]
  # 検索方法→params[:search]
  # 検索ワード→params[:word]
end
