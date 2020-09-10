class Book < ApplicationRecord
	belongs_to :user, optional: true
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def self.search(search, word)
        if search == "forward_match"
            @book = Book.where("title LIKE?","#{word}%")
        elsif search == "backward_match"
            @book = Book.where("title LIKE?","%#{word}")
        elsif search == "perfect_match"
            @book = Book.where("#{word}")
        elsif search == "partial_match"
            @book = Book.where("title LIKE?","%#{word}%")
        else
            @book = Book.all
        end
    end
end
