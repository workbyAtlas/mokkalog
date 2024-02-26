class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: %i[slugged finders history]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable

  validates :name, length: { maximum: 20 }
  validates :name, format: { with: /\A[a-zA-Z0-9]+\z/, message: "can only contain letters and numbers" }
  validates :username, format: { with: /\A[a-zA-Z0-9_]+\z/, message: "can only contain letters, numbers, and underscores" }
  
  validates :last_name, length: { maximum: 20 }, allow_blank: true
  validates :description, length: { maximum: 500 }, allow_blank: true


  #Associations
  has_one_attached :avatar
  has_many :posts
  has_many :brands
  has_many :blogs
  has_many :collections #depedent destroy??
  has_many :activities
  has_many :pagelinks, dependent: :destroy

  has_many :likeables, dependent: :destroy

  has_many :liked_posts, through: :likeables, source: :post
  has_many :liked_brands, through: :likeables, source: :likeable, source_type: 'Brand'

  has_many :favoritables, dependent: :destroy
  has_many :favorited_posts, through: :favoritables, source: :post
  before_destroy :reassign_posts

  #User Role
  enum role: [:user, :editor, :mod,:developer, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  #Onboarding(Wicked)------------------------------------------------------
  attr_accessor :current_step
  validates :username, uniqueness: true, presence: true, if: :username_step?

  def username_step?
    current_step == :username
  end

  def should_generate_new_friendly_id?
   username_changed? || slug.blank?
  end

  def like(likeable)
    likeables.find_or_create_by(likeable: likeable)
  end

  def unlike(likeable)
    likeables.where(likeable: likeable).destroy_all
  end

  def like_for_post(likeable)
    existing_like = Likeable.find_by(likeable: likeable, user_id: id)

    if existing_like
      # Unlike the post
      existing_like.destroy
    else
      # Like the post
      Likeable.create(likeable: likeable, user_id: id)
    end
  end

  def liked?(likeable)
    likeables.exists?(likeable: likeable)
  end


  def liked_brands
    Brand.joins(:likeables).where(likeables: {user_id: id})  
  end

  def liked_posts
    Post.joins(:likeables).where(likeables: { user_id: id })
  end

  def liked_collections
    Collection.joins(:likeables).where(likeables: { user_id: id })
  end

  def favorited?(post)
    favorited_posts.include?(post)
  end
  def favorite(post)
    if favorited_posts.include?(post)
      favorited_posts.destroy(post)
    else
      favorited_posts << post
    end
  end

  def image_as_avatar
    avatar.variant(resize_to_fill: [60,60]).processed if avatar.attached?
  end

  def image_as_profile_page_pic
    avatar.variant(resize_to_fill: [200,200]).processed if avatar.attached?
  end

  def image_as_circle
    avatar.variant(combine_options: {resize: "200x200", background: "none", 
      gravity: "center"}).processed
  end

  private
    def reassign_posts
    # Update the user_id of all posts to a specific value (e.g., 1) before the user is destroyed
    posts.update_all(user_id: 1)
  end

end
