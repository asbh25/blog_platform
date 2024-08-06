# frozen_string_literal: true

module Api
  module V1
    class PostsController < BaseController
      def index
        authorize Post

        render json: Posts::List.call(posts_params)
      end

      def show
        authorize Post

        render json: PostSerializer.render_as_hash(post)
      end

      def create
        new_post = current_user.posts.build(post_params)
        authorize new_post

        if new_post.save
          render json: PostSerializer.render_as_hash(new_post), status: :created
        else
          render json: post.errors, status: :unprocessable_entity
        end
      end

      def update; end
      def destroy; end

      private

      def post
        @post ||= Post.find_by!(id: params[:id])
      end

      def posts_params
        params.permit(:page, :per_page, :user_id)
      end

      def post_params
        params.require(:post).permit(:title, :text)
      end
    end
  end
end
