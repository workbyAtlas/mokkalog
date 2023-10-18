class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: %i[slugged]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable

  validates :username, uniqueness: true, presence: true
  #validates :link1, format: { with: /\Ahttps:\/\//, message: "should start with 'https://" }, allow_blank: true
  #validates :link2, format: { with: /\Ahttps:\/\//, message: "should start with 'https://" }, allow_blank: true
  validates :link1_title, length: { maximum: 20 }, allow_blank: true
  validates :link2_title, length: { maximum: 20 }, allow_blank: true
  validates :name, length: { maximum: 20 }
  validates :last_name, length: { maximum: 20 }, allow_blank: true
  validates :description, length: { maximum: 500 }, allow_blank: true

  has_one_attached :avatar
  has_many :posts
  has_many :brands
  has_many :blogs

  has_many :likeables, dependent: :destroy
  has_many :liked_posts, through: :likeables, source: :post

  has_many :favoritables, dependent: :destroy
  has_many :favorited_posts, through: :favoritables, source: :post

  has_many :pagelinks, dependent: :destroy

  before_destroy :reassign_posts

  #regular user
  #editor
  enum role: [:user, :editor, :mod,:developer, :admin]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :user
  end

  def should_generate_new_friendly_id?
   username_changed? || slug.blank?
  end

  def liked?(post)
    liked_posts.include?(post)
  end
  def like(post)
    if liked_posts.include?(post)
      liked_posts.destroy(post)
    else
      liked_posts << post
    end

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
    #return unless avatar.content_type.in?(%w[image/jpeg image/png image/webp])
    #avatar.variant(resize_to_fill: [100,100]).processed if avatar.attached?
    avatar.variant(resize_to_fill: [60,60]).processed if avatar.attached?
  end

  def image_as_avatar_blog
    #return unless avatar.content_type.in?(%w[image/jpeg image/png image/webp])
    #avatar.variant(resize_to_fill: [100,100]).processed if avatar.attached?
    avatar.variant(resize_to_fill: [100,100]).processed if avatar.attached?
  end

  def image_as_profile_page_pic
    #return unless avatar.content_type.in?(%w[image/jpeg image/png image/webp])
    #avatar.variant(resize_to_fill: [100,100]).processed if avatar.attached?
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
