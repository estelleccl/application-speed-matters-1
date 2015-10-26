class UsersController < ApplicationController
  def index
    @users = User.by_total_points.limit(50)
  end
end
