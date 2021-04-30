module Api
    module V1
        class TweetController < ApiController
            before_action :authenticate_user!
            before_action :set_tweet, only: [:show, :destroy]

            #GET api/v1/tweets
            def index
              @tweets= Tweet.all
              #@tweets = Tweet.where[user_id: current_user.id]
              render json: @tweets
            end
            
            #POST api/v1/tweets
            def create
              @tweet=Tweet.new(tweet_params)
              @tweet.user_id = @current_user_id
              # TODO: Implement auth
              if @tweet.save
                render json: {info: "Tweet creado", tweet: @tweet}, status: 201
              else
                #render json: { error: "Excede el limite de 280 caracteres"}, status: :unprocessable_entity
              end    
            end

            #DEL api/v1/tweets
            def destroy       
              if @tweet.destroy
                render json: "Tweet borrado", status: 200
              end
            end

            #GET api/v1/tweets/:id
            def show
              render json: @tweet
            end            

            def tweet_params
              params.permit( :description)#, :user_id)
            end

            private

            def set_tweet
              begin
                @tweet=Tweet.find(params[:id])
              rescue ActiveRecord::RecordNotFound
                render json: {error: "Tweet no encontrado"}, status: 404
              end
            end

        end
    end
end
