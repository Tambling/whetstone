class VotesController < ApplicationController

  def create
    @voteable = find_voteable
    vote = @voteable.votes.build(user_id: current_user.id, value: params[:value])
    unless vote.save
      flash[:error] = "You can't vote twice on the same thing!"
      render status: 403
    end
  end

  private

  def find_voteable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
