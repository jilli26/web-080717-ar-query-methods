class Movie < ActiveRecord::Base
  has_many :reviews
  has_many :movie_categories
  has_many :categories, through: :movie_categories

  def self.average_rating
    #  very close
    self.joins(:reviews).group('movies.id').average('reviews.rating')
  end

  def self.eighties
    self.where(release_year: (1980..1989))
  end

  def self.average_rating_eighties_movies

  end

  def self.highest_rated

  end

  def self.lowest_rated
  end

  def self.most_reviewed
    # raw SQL
    # "SELECT * FROM movies INNER JOIN reviews ON reviews.movie_id = movies.id GROUP BY movies.id ORDER BY COUNT(reviews.movie_id) desc"

    # ruby iterative ( n + 1 )
    # Movie.all.max_by do |movie|
    #   movie.reviews.length
    # end

    self.joins(:reviews).group('reviews.movie_id').order('COUNT(reviews.movie_id) desc').limit(1).first
  end

  def average_rating
    # raw SQL way
    # "SELECT AVG(reviews.rating) FROM reviews WHERE reviews.movie_id = 1"

    # ruby, iterative way
    # total = 0
    # self.reviews.each do |review|
    #   total += review.rating
    # end
    #
    # total.to_f / self.reviews.length

    self.reviews.average(:rating).to_f
  end

  def number_of_reviews

  end

end
