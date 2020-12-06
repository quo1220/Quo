class CommentsController < ApplicationController
  before_action :authenticate_user
  #before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}
  protect_from_forgery :except => [:destroy]

  def new
    @post = Post.find_by(id: params[:id])
    @comment= Comment.new


  end

  def create
    @post = Post.find_by(id: params[:id])
    @comment= @post.comments.create(message: params[:message], user_id: @current_user.id)
    if @comment.save
      flash[:notice]= "Comment has been registered!"
      redirect_to("/posts/#{@post.id}")
    else
      flash[:notice]= "something went wrong..try again!"
      render("posts/#{@post.id}")
    end
  end

  def reply
    @comment=Comment.find_by(id: params[:id])
    @to_reply= Comment.find_by(id: params[:id])
    @post=Post.find_by(id: @comment.post_id)
    @user = @post.user
    @postType = PostType.find_by(id: @post.post_type)
    @cid= params[:id]
  end

  def create_r
    @cid= params[:id]
    @to_reply= Comment.find_by(id: @cid)
    @post=Post.find_by(id: @to_reply.post.id)
    @user = @post.user
    @comment= @post.comments.create(message: params[:message], user_id: @current_user.id, comment_id: @cid)
    @comment.save
    @postType = PostType.find_by(id: @post.post_type)
    if @comment.save
      flash[:notice]= "Comment has been registered!"
      redirect_to("/posts/#{@post.id}")
    else
      flash[:notice]= "something went wrong..try again!"
      render("posts/#{@post.id}/comments/new")
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    if @comment
      if params[:message].present?
        @comment.message = params[:message]
        if @comment.save
          flash[:notice]= "Modified successfully!"
          redirect_to("/posts")
        else
          show_error("Save function went wrong..try again!","comments/#{@comment.id}/edit")
        end
      else
        show_error("Please fill the message..try again!!!!","comments/#{@comment.id}/edit")
      end
    else
      show_error("Inserted id doesn't exist..try again!","comments/#{@comment.id}/edit")
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    flash[:notice]= "Deleted successfully!"
    @comment.destroy
    redirect_to("/posts")
  end



  private  ## has to be the bottom of the page not to let other method as private one
  def show_error (error_message, return_to_address)
    flash[:notice]= error_message
    render(return_to_address)
  end
end
