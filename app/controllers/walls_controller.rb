class WallsController < ApplicationController

  before_action :authenticate_user
  
 
  def new
    @key = Rails.application.credentials.secret_key_base[0..15]
    @wall= Wall.new
    @user= User.find(params[:id])
    @friendship = Friendship.find_by(user_id: @current_user.id ,receiver_id: params[:id])
  	@friendship = Friendship.find_by(receiver_id: @current_user.id ,user_id: params[:id]) if @friendship.nil?
  	if @friendship.nil?
  		flash[:notice]= "To send a message, you need to become friend as a first..Try to ask :)"
  		render("users/#{params[:id]}") 
  	end
    @previous_wall= Wall.find_by(friendship_id: @friendship.id)
    if !@previous_wall.nil?
    	redirect_to("/walls/#{@friendship.id}/reply")
    end
  end

  def create
    @friendship = Friendship.find_by(user_id: @current_user.id ,receiver_id: params[:id])
  	@friendship = Friendship.find_by(receiver_id: @current_user.id ,user_id: params[:id]) if @friendship.nil?
  	if @friendship.nil?
  		flash[:notice]= "To send a message, you need to become friend as a first..Try to ask :)"
  		render("users/#{params[:id]}") 
  	end
    str = params[:message]#"Nice little string."
    @key = Rails.application.credentials.secret_key_base[0..15]
    x = str ^ @key
    #byebug
    #orig = x ^ key
    #@wall= @friendship.walls.create(message: params[:message], sender_id: @current_user.id)
    @wall= @friendship.walls.create(message: x.tr("\u0000",''), sender_id: @current_user.id)
    if @wall.save
      #flash[:notice]= "Chat message has been registered!#{ @wall.message ^ @key  }"
      flash[:notice]= "Chat message has been registered!"
      redirect_to("/walls/#{@friendship.id}/reply")
    else
      flash[:notice]= "something went wrong..try again!"
      render("walls/#{params[:id]}/new")
    end
  end
  def reply
    @key = Rails.application.credentials.secret_key_base[0..15]
    @walls=Wall.where(friendship_id: params[:id])
    if @walls.nil?
  		flash[:notice]= "To send a message, you need to become friend as a first..Try to ask :)"
  		render("users/#{params[:id]}") 
  	end
  end

  def update
    @friendship= Friendship.find(params[:id])
    if @friendship.nil?
  		flash[:notice]= "To send a message, you need to become friend as a first..Try to ask :)"
  		render("users/#{params[:id]}") 
  	end
    str = params[:message]#"Nice little string."
    @key = Rails.application.credentials.secret_key_base[0..15]
    x = str ^ @key
    @wall= @friendship.walls.create(message: x.tr("\u0000",''), sender_id: @current_user.id)
    
    #@wall= @friendship.walls.create(message: params[:message], sender_id: @current_user.id)
    #@wall= @friendship.walls.create(message: x, sender_id: @current_user.id)
    if @wall.save
      flash[:notice]= "Chat message has been registered!"
      #flash[:notice]= "Chat message has been registered!#{ @wall.message ^ @key  }"
      redirect_to("/walls/#{@friendship.id}/reply")
    else
      flash[:notice]= "something went wrong..try again!"
      render("walls/#{params[:id]}/new")
    end
  end

  #private
  def ^(key)
    kenum = key.each_byte.cycle
    #kenum = Rails.application.credentials.secret_key_base.each_byte.cycle
    each_byte.map {|byte| byte ^ kenum.next }.pack("C*")#.force_encoding(self.encoding)
  end
end

class String
  def ^(key)
    kenum = key.each_byte.cycle
    #kenum = Rails.application.credentials.secret_key_base.each_byte.cycle
    each_byte.map {|byte| byte ^ kenum.next }.pack("C*")#.force_encoding(self.encoding)
  end
end


