class SongsController < ApplicationController
  def index
  #  @songs = Song.all
    if params[:artist_id]
   # input =(
     # if (Integer(params[:artist_id]) rescue nil)
       if !(@songs = Artist.find(params[:artist_id]).songs rescue nil)
         flash[:alert]="Artist not found."
         redirect_to artists_path
      end
   else
     @songs = Song.all
   end
   # binding.pry
  end

  def show
    @song = Song.find(params[:id]) rescue nil
    if !@song && params[:artist_id]
        @artist=Artist.find(params[:artist_id])
        flash[:alert]="Song not found."
        redirect_to artist_songs_path(@artist)
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
