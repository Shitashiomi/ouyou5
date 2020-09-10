class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}

  def self.search(search, word)
        if search == "forward_match"
            @user = User.where("name LIKE?","#{word}%")
        elsif search == "backward_match"
            @user = User.where("name LIKE?","%#{word}")
        elsif search == "perfect_match"
            @user = User.where("#{word}")
        elsif search == "partial_match"
            @user = User.where("name LIKE?","%#{word}%")
        else
            @user = User.all
        end
    end
end
