class PostsController < ApplicationController

  before_action :authenticate_user
  before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}
  protect_from_forgery :except => [:destroy]


  def index
  	@posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @postType = PostType.find_by(id: @post.post_type)

  end

  def new
  	@post = Post.new
    @postTypes = PostType.all
    @names=@postTypes.map{|x| x.name}
  end

  def create
  	@post = Post.new
    @postTypes = PostType.all
    @names=@postTypes.map{|x| x.name}
    @post.title=allowed_params["title"]
    @post.detail=allowed_params["detail"]
    @postType = PostType.find_by(name: allowed_params["post_type"])
    @post.post_type=@postType.id  
    @post.user_id= @current_user.id
 
    if @post.save
      flash[:notice]= "New post created successfully!"
      redirect_to("/posts")
    else
      show_error("Some error occured..try again!","posts/new")
    end
  end

  def edit
  	@post = Post.find_by(id: params[:id])
    @postTypes = PostType.all
    @names=@postTypes.map{|x| x.name}
  end

  def update
  	@postTypes = PostType.all
    @post = Post.find_by(id: params[:id])
    @names=@postTypes.map{|x| x.name}


    @post.title=allowed_params["title"]
    @post.detail=allowed_params["detail"]
    @postType = PostType.find_by(name: allowed_params["post_type"])
    @post.post_type=@postType.id
    @post.user_id= @current_user.id
    
    if @post.save
      flash[:notice]= "Post has been modified successfully!"
      redirect_to("/posts/#{@post.id}")
    else
      @post = Post.find_by(id: params[:id])
      #render("posts")
      flash[:notice]="Some error occured..try again!"
      redirect_to("/posts/#{@post.id}/edit")
      #show_error("Inserted id doesn't exist..try again!","posts/#{@post.id}")
    end
  end

  def destroy
  	@post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice]= "Deleted successfully!"
    redirect_to("/posts")
  end

  def delete
  	@post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice]= "Deleted successfully!"
    redirect_to("/posts")
  end



  private  ## has to be the bottom of the page not to let other method as private one
  def show_error (error_message, return_to_address)
    flash[:notice]= error_message
    render(return_to_address)
  end

  def ensure_correct_user
    @post= Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice]= "You don't have a right to modify this page"
      redirect_to("/posts")
    end
  end

  def allowed_params
    params.require(:post).
      permit(:title, :detail, :post_type)
  end

end
