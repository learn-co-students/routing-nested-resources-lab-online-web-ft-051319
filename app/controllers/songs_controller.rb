class SongsController < ApplicationController

    def index
      if params[:artist_id]
        artist = Artist.find_by(id: params[:artist_id])
        # if artist_id is provided in params, assign artist, go to artist's song list
        if artist.nil?
          flash[:alert] = "Artist not found."
          redirect_to artists_path
          # if artist_id is nil, show alert, redirect to the artists list
        else
          @songs = artist.songs
          # if artist_id is not nil, assign songs array vaiable for that artist
        end
      else
        @songs = Song.all
        # if artist_id is not provided through params, assign all songs array and show all songs as normal
      end
    end

    def show
      if params[:artist_id]
        @artist = Artist.find_by(id: params[:artist_id])
        # if song has an artist, assign artist variable
        if @artist.nil?
          redirect_to artists_path
          # if there is artist_id is nil, redirect to all artists list
        else
          @song = @artist.songs.find_by(id: params[:id])
          # if there is artist_id is not nil, assign song variable using artist
          if @song.nil?
            flash[:alert] = "Song not found."
            redirect_to artist_songs_path(@artist)
            # if song_id does not exist, show alert, redirect to the artist's song list
          end
        end
      else
        @song = Song.find_by(id: params[:id])
        # if artist_id not provided through params, assign song variable and show song
      end
    end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end
