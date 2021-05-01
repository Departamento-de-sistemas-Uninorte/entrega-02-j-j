class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:show, :destroy]
  
  def index
    @tweets= Tweet.all
  end

  def create
    @tweet=Tweet.new(tweet_params)
    if @tweet.save
      redirect_to tweets_path, notice: "Tweet publicado"
    else
      redirect_to new_tweet_path
    end    
  end

  def destroy    
    @tweet.destroy
    redirect_to tweets_path, notice: "Tweet eliminado"
    
  end

  def show
  end

  def tweet_params
    params.require(:tweet).permit(:tittle, :description, :user_id)
  end

  private

  def set_tweet
    @tweet=Tweet.find(params[:id])
  end



end
