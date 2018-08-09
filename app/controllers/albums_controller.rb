class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :update, :destroy]

  # GET /albums
  # This works, test it in incognito mode with:
  # https://accounts.spotify.com/authorize/?client_id=c4b89345becb45f7b9289414554c088c&response_type=code&redirect_uri=http%3A%2F%2Flocalhost%3A7165&scope=user-read-email
  def index
    @albums = HTTParty.get('https://accounts.spotify.com/authorize',
      :headers => { 'Content-Type' => 'application/json' },
      query: {
        'client_id' => ENV['SPOTIFY_CLIENT_ID'],
        'response_type' => 'code',
        'redirect_uri' => 'http://localhost:7165',
        'scope' => 'user-read-email'
      })
    render json: @albums
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def album_params
      params.fetch(:album, {})
    end
end
