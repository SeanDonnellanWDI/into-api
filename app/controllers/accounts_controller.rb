# frozen_string_literal: true

class AccountsController < ProtectedController
  skip_before_action :authenticate, only: %i[callback]
  before_action :set_account, only: %i[show update destroy]

  # GET /accounts
  def index
    @accounts = current_user.accounts

    render json: @accounts
  end

  # GET /accounts/1
  def show
    render json: @account
  end

  # POST /accounts
  def create
    @account = current_user.accounts.build(account_params)

    if @account.save
      render json: @account, status: :created
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
  end

  # Spotify Authentication, create Spotify account
  # GET /callback
  def callback
    @sp_service = 'Spotify'
    puts "111 @sp_service is #{@sp_service}"
    @sp_code = params['code']
    puts "222 @sp_code is #{@sp_code}"
    @user = User.find(params['state'])
    puts "333 @user is #{@user}"
    @client_id = ENV['SPOTIFY_CLIENT_ID']
    puts "333333 client_id is #{@client_id}"
    @client_secret = ENV['SPOTIFY_CLIENT_SECRET']
    puts "333333333 client_secret is #{@client_secret}"
    @sp_access = HTTParty.post('https://accounts.spotify.com/api/token',
                               headers: { 'Authorization' => "Bearer #{@sp_access_token}", 'Accept' => 'application/json' },
                               body: {
                                 'client_id' => @client_id,
                                 'client_secret' => @client_secret,
                                 'grant_type' => 'authorization_code',
                                 'code' => @sp_code,
                                 'redirect_uri' => 'https://into-api.herokuapp.com/callback'
                               })
    puts "444 @sp_access is #{@sp_access}"
    @sp_parse_access = JSON.parse(@sp_access.body)
    puts "555 @sp_parse_access is #{@sp_parse_access}"
    @sp_access_token = @sp_access['access_token']
    puts "666 @sp_access_token is #{@sp_access_token}"
    @sp_data = HTTParty.get('https://api.spotify.com/v1/me',
                            headers: { 'Authorization' => "Bearer #{@sp_access_token}", 'Accept' => 'application/json' })
    puts "777 @sp_data is #{@sp_data}"
    @sp_user_email = @sp_data['email']
    puts "888 @sp_user_email is #{@sp_user_email}"
    Account.create(user_id: @user.id,
                   service: @sp_service,
                   username: @sp_user_email)
    redirect_to 'https://seandonn.io/into-client/#/account'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = current_user.accounts.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def account_params
    params.require(:account).permit(:service, :username, :user_id)
  end
end
