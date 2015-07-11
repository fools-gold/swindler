class StoriesController < ApplicationController
  before_action :set_story, only: [:destroy]
  before_action :authenticate_user!, only: [:index, :create, :destroy]

  def index
    @stories = Story.related_to current_user
    @new_story = current_user.stories.build
  end

  def create
    @story = current_user.stories.build(story_params)
    if @story.save
      redirect_to root_url, notice: "Story was successfully created."
    else
      redirect_to root_url, error: "Error occured while creating a new story."
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
    params.require(:story).permit(:body, :of_id, :game_id, :photo)
  end
end
