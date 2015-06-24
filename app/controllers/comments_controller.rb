class CommentsController < ApplicationController
  before_action :set_story
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_comment, only: :destroy
  before_action :authorize!, only: :destroy

  def create
    Comments::CreateService.new(current_user, @story, params[:body]).run!
    head :ok
  end

  def destroy
    Comments::DestroyService.new(current_user, @comment).run!
    head :no_content
  end

  def index
    @comments = @story.comments
  end

  def recent
    @comments = @story.comments.order(created_at: :desc).limit(5)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_story
    @story = Story.find(params[:story_id])
  end

  def authorize!
    head :unauthorized unless current_user == @comment.user
  end
end
