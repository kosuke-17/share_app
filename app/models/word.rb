class Word < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to       :genre
  belongs_to       :user
  has_one_attached :image
  has_many         :comments, dependent: :destroy

  def self.search(search)
    if search != ""
      Word.where('name LIKE(?)', "%#{search}%")
    else
      Word.all
    end
  end

  with_options presence: true do
    validates :title,  presence: true
    validates :note,  presence: true
    validates :image
  end

  validates :genre_id, numericality: { other_than: 1 }
end
