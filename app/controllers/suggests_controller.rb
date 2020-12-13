class SuggestsController < ApplicationController

  before_action :authenticate_user

  def index
  end

  def new
    @post = Post.find_by(id: params[:id])
    @suggest= Suggest.new
    @suggestTypes = SuggestType.all
    @names=@suggestTypes.map{|x| x.name}

  end

  def create
    @post = Post.find_by(id: params[:id])
    @suggestTypes = SuggestType.all
    @names=@suggestTypes.map{|x| x.name}
    @suggestType = SuggestType.find_by(name: allowed_params["suggest_type"])
    @suggest= @post.suggests.create(name: allowed_params[:name], about: allowed_params[:about], 
    	suggest_type: @suggestType.id,user_id: @current_user.id)
    if @suggest.save
      flash[:notice]= "Suggestion has been registered!"
      redirect_to("/posts/#{@post.id}")
    else
      flash[:notice]= "something went wrong..try again!"
      render("posts/#{@post.id}")
    end
  end

  private
  def allowed_params
    params.require(:suggest).
      permit(:name, :about, :suggest_type)
  end
end
