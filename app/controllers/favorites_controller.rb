class FavoritesController < ApplicationController

  def create
    favorite = current_user.favorites.create(blog_id: params[:blog_id])
    redirect_to blogs_url, notice:"#{favorite.blog.user.name}さんのブログをお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to blogs_url, notice:"#{favorite.blog.user.name}さんのブログをお気に入り解除しました"
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
