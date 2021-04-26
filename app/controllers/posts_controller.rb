class PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id if user_signed_in?
		if @post.save
			redirect_to root_path, flash: { success: 'Post was created' }
		else
			redirect_to new_post_path, flash: { success: 'Post was not created' }
		end
	end

	def destroy
		@post = Post.find(params[:id])
		return unless current_user.id == @post.user_id

		@post.destroy
		flash[:success] = 'Post deleted'
		redirect_back(fallback_location: root_path)
	end

	private

	def post_params
		params.require(:post).permit(:content, :image, :image_cache)
	end 
end