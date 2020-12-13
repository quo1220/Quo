class LinksController < ApplicationController

  before_action :authenticate_user, {only: [:new, :create]}

  def index
  	@links = Link.all.order(created_at: :desc)
  end

  def new
  	@link = Link.new
    @linkTypes = PostType.all
    @names=@linkTypes.map{|x| x.name}
  end

  def create
  	@link = Link.new
    @linkTypes = PostType.all
    @names=@linkTypes.map{|x| x.name}
    @link.title=allowed_params["title"]
    @link.url=allowed_params["url"]
    @link.about=allowed_params["about"]
    @linkType = PostType.find_by(name: allowed_params["link_type"])
    @link.link_type=@linkType.id  
    @link.user_id= @current_user.id
 
    if @link.save
      flash[:notice]= "New link added successfully!"
      redirect_to("/links/index")
    else
      show_error("Some error occured..try again!","links/new")
    end
  end
  
  def future_plan
  	@links = Link.where(link_type: 6).order(created_at: :desc)
  end
  
  def health
  	@links = Link.where(link_type: 4).order(created_at: :desc)
  end
  
  def relationship
  	@links = Link.where(link_type: 1).order(created_at: :desc)
  end
  
  def self_confidence
  	@links = Link.where(link_type: 2).order(created_at: :desc)
  end
  
  def self_progress
  	@links = Link.where(link_type: 3).order(created_at: :desc)
  end
  
  def society
  	@links = Link.where(link_type: 5).order(created_at: :desc)
  end

  private
  def allowed_params
    params.require(:link).
      permit(:title, :url, :link_type, :about)
  end

end
