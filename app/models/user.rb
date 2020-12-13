class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friendships, foreign_key: :receiver_id, dependent: :destroy

  has_many :walls, foreign_key: :sender_id, dependent: :destroy
  has_many :links, dependent: :destroy

  has_many :suggests, dependent: :destroy

  def friends
  	@friendships1= Friendship.where(user_id: self.id, confirmed: true)
  	@friendships2= Friendship.where(receiver_id: self.id, confirmed: true)
  	@friends1=@friendships1.map {|friendship| friendship.receiver_id}
  	@friends2=@friendships2.map {|friendship| friendship.user_id}
  	@friends= @friends1+ @friends2
  end

  def waitlist
    @friendships1= Friendship.where(user_id: self.id, confirmed: false)
    @friendships2= Friendship.where(receiver_id: self.id, confirmed: false)
    @friends1=@friendships1.map {|friendship| friendship.receiver_id}
    @friends2=@friendships2.map {|friendship| friendship.user_id}
    @waitlist= @friends1+ @friends2
  end


  def requests
  	
  	@friendships= Friendship.where(receiver_id: self.id, confirmed: false)
  	@requests=@friendships.map {|friendship| friendship.user_id}
 
  end
end
