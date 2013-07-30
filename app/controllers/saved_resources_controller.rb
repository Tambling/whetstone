class SavedResourcesController < ApplicationController
  def create
    unless user_signed_in?
      render :json => "You need to sign in to save resources".to_json
    else
      resources_stone = ResourcesStone.find(params[:id])
      goal = current_user.goals.find_or_create_by_stone_id(resources_stone.stone.id)


      saved_resource = SavedResource.new(goal_id: goal.id, resources_stone_id: resources_stone.id)

      if saved_resource.valid?
        saved_resource.save
        goal.queue+=", #{saved_resource.id}"
        goal.save
        render :json => "Creation Successful".to_json
      else
        render :json => "Resource has already been added".to_json
      end
    end
  end
end
