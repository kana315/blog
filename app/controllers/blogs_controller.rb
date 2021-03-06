class BlogsController < ApplicationController
  before_action :no_logged_in, only: [:new, :show, :edit, :destroy]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def top
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
      @blog.image.retrieve_from_cache! params[:cache][:image]
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    @blog.image.retrieve_from_cache! params[:cache][:image]
    if @blog.save
      NoticeMailer.notice_email(@blog).deliver
      redirect_to "/blogs/new", notice:"ブログを作成しました!"
    else
      render 'new'
    end
  end

  def edit
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice:"ブログを編集しました"
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました"
  end

  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    render :new if @blog.invalid?
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content, :image, :image_cache)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def no_logged_in
    unless current_user.present?
      redirect_to new_session_path
    end
  end

end
