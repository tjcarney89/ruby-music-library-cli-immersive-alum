class Genre
  attr_accessor :name, :songs

  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    @songs << song if !@songs.include?(song)
    if song.genre == nil
      song.genre = self
    end
  end

  def artists
    artists = []
    @songs.each do |song|
      artists << song.artist unless artists.include?(song.artist)
    end
    artists
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    included = false
    @@all.each do |genre|
      if genre.name == self.name
        included = true
      end
    end
    if !included
      @@all << self
    end
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end

end
