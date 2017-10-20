class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    #@blogs = Blog.all
    #raise
    #binding.pry
    @q = Blog.ransack(params[:q])
    @blogs = @q.result
    #@blogs = Blog.search(title_eq: 'テスト１').result
  end

  def show
    @comment = @blog.comments.build
    @comments = @blog.comments
   Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
  end

  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blogs_params)
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to blogs_path, notice: "レシピを投稿しました！"
#      NoticeMailer.sendmail_blog(@blog).deliver
    else
      render 'new'
    end
  end

  def edit
  #  @blog = Blog.find(params[:id])
    if(@blog.user_id == current_user.id)
      @blog = Blog.find(params[:id])
    else
      redirect_to blogs_path, notice: "自分の投稿以外は編集できません"
    end
  end

  def update
  # edit, update, destroyで共通コード
  #  @blog = Blog.find(params[:id])

    if @blog.update(blogs_params)
      redirect_to blogs_path, notice: "レシピを更新しました！"
    else
      render 'edit'
    end
  end

  def destroy
  #  edit, update, destroyで共通コード
  #  @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "レシピを削除しました！"
  end

  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end

  private
    def blogs_params
        params.require(:blog).permit(:title, :content, :image, :image_cache)
    end
    # idをキーとして値を取得するメソッド
    def set_blog
      @blog = Blog.find(params[:id])
    end
end
