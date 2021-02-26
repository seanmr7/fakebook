class LikesController < ApplicationController
  
  def create
    @like = Like.new
    @like.post_id = params[:post_id]
    @like.user_id = current_user.id
    

    respond_to do |format|
      if @like.save
        format.html { redirect_back fallback_location: root_path, notice: "Liked!" }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { redirect_back fallback_location: root_path }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: params[:user_id])
    return unless @like

    @like.destroy
    redirect_back fallback_location: root_path
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :user_id)
  end
end