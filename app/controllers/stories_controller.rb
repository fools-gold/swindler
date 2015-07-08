class StoriesController < ApplicationController
  before_action :set_story, only: [:destroy]
  before_action :authenticate_user!, only: [:index, :create, :destroy]
  before_action :authorize!, only: [:create, :destroy]

  def index
    @stories = Story.related_to current_user
  end

  def create
    @story = current_user.stories.build(story_params)

    if @story.save
      redirect_to @story, notice: "Story was successfully created."
    else
      render :new
    end
  end

  def destroy
    @story.destroy
    redirect_to stories_url, notice: "Story was successfully destroyed."
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:body, :by, :of, :game, :photo)
  end

  def authorize!
    head :forbidden unless current_user == @user
  end
end
