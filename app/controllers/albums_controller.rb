# frozen_string_literal: true

require 'pry'

class AlbumsController < ApplicationController
  before_action :set_album, only: %i[show update destroy]

  # GET /callback

  # This function performs the necessary steps to connect to Spotify API and
  # retrieve the data of the authenticated user.

  # https://developer.spotify.com/documentation/general/guides/authorization-guide/
  # High level steps as outlined in the Spotify docs:
  # 1. Have your application request authorization; the user logs in and
  # authorizes access (see hard coded link)
  # 2. Have your application request refresh and access tokens; Spotify returns
  # access and refresh tokens (see callback method)
  # 3. Use the access token to access the Spotify Web API; Spotify returns
  # requested data (see callback method)
  # 4. Requesting a refreshed access token; Spotify returns a new access token
  # to your app

  # Step 1
  # When a user clicks the client-facing hardcoded link (labelled with
  # `id='spotify-auth-hard-link'`), the user is taken to the spotify
  # authentication page.
  ######### Example hard coded link: https://accounts.spotify.com/authorize/?client_id=c4b89345becb45f7b9289414554c088c&response_type=code&redirect_uri=http%3A%2F%2Flocalhost%3A4741%2Fcallback&scope=user-read-email&state=abcdefghijklmnopqrstuvwxyz0123456789
  ######### Example HTTParty link:
  #########   @spotifyAuth = HTTParty.get('https://accounts.spotify.com/authorize',
  #########     :headers => { 'Content-Type' => 'application/json' },
  #########     query: {
  #########       'client_id' => ENV['SPOTIFY_CLIENT_ID'],
  #########       'response_type' => 'code',
  #########       'redirect_uri' => 'http://localhost:4741/callback',
  #########       'scope' => 'user-read-private user-read-email',
  #########       'state' => 'abcdefghijklmnopqrstuvwxyz0123456789'
  #########     }
  #########   )
  # The user must go through the steps to authenticate INTO's access to the user
  # data. After the steps are complete, Spotify sends the user to the redirect
  # URL, which is currently localhost:4741/callback. That get request is routed
  # in routes.rb as `get '/callback' => 'albums#callback'` which triggers Step
  # 2 which is the callback method defined below

  # Step 2
  # When the authorization `code` has been received, you will need to exchange
  # it with an access token by making a POST request to the Spotify Accounts
  # service, this time to its /api/token endpoint.
  def callback
    # Store the code
    @code = params['code']

    # Perform POST request
    @access = HTTParty.post('https://accounts.spotify.com/api/token',
      :headers => { 'Accept' => 'application/json' },
      query: {
        # When you register your application, Spotify provides you a Client ID
        'client_id' => ENV['SPOTIFY_CLIENT_ID'],
        # Request client_secret in registered app in Spotify dashboard
        'client_secret' => ENV['SPOTIFY_CLIENT_SECRET'],
        # As defined in the OAuth 2.0 specification, this field must contain the
        # value "authorization_code"
        'grant_type' => 'authorization_code',
        # The authorization code returned from the initial request to the
        # Account /authorize endpoint
        'code' => @code,
        # This parameter is used for validation only (there is no actual
        # redirection). The value of this parameter must exactly match the value
        #  of redirect_uri supplied when requesting the authorization code.
        'redirect_uri' => 'http://localhost:4741/callback'
      })
    # This should return an access_token, token_type, scope, expires_in, and
    # refresh_token

    # Step 3. Use the access token to access the Spotify Web API; Spotify
    # returns requested data
    # Retrieve the access_token, store it
    @access_token = @access['access_token']

    # Perform data request on behalf of a user by using their access_token
    @spotify_data_request = HTTParty.get('https://api.spotify.com/v1/me',
      :headers => { 'Accept' => 'application/json' },
      query: {
        'access_token' => @access_token
      })
    Album.create(email: @spotify_data_request['email'])
    # Render the json object returned by the data access request
    # render json: @spotify_data_request
    # Or, redirect back to the app
    redirect_to "http://localhost:7165/account"
  end

  private

  # Use accounts to share common setup or constraints between actions.
  def set_album
    @album = Album.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def album_params
    params.fetch(:album, {})
  end
end
