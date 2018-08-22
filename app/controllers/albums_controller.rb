# frozen_string_literal: true

require 'pry'

class AlbumsController < ApplicationController
  before_action :set_album, only: %i[show update destroy]

  # GET /albums
  # This works, test it in incognito mode with:
  # https://accounts.spotify.com/authorize/?client_id=c4b89345becb45f7b9289414554c088c&response_type=code&redirect_uri=http%3A%2F%2Flocalhost%3A4741%2Fcallback&scope=user-read-email&state=abcdefghijklmnopqrstuvwxyz0123456789
  def index
    @albums = HTTParty.get('https://accounts.spotify.com/authorize',
      :headers => { 'Content-Type' => 'application/json' },
      query: {
        'client_id' => ENV['SPOTIFY_CLIENT_ID'],
        'response_type' => 'code',
        'redirect_uri' => 'http://localhost:4741/callback',
        'scope' => 'user-read-private user-read-email',
        'state' => 'abcdefghijklmnopqrstuvwxyz0123456789'
      })
    render json: @albums
  end

  def example
    @access = HTTParty.post('https://accounts.spotify.com/api/token',
      :headers => { 'Accept' => 'application/json' },
      query: {
        'client_id' => ENV['SPOTIFY_CLIENT_ID'],
        'client_secret' => ENV['SPOTIFY_CLIENT_SECRET'],
        'grant_type' => 'authorization_code',
        'code' => params['code'],
        'redirect_uri' => 'http://localhost:4741/callback'
      })
    render json: @access
  end

  def data
    redirect_to 'https://api.spotify.com/v1/me?access_token=', @access.response.body['access_token']
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
