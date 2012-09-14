class ApplicationController < ActionController::Base
  protect_from_forgery

  def load_lists
    @past_list = List.find(:past)
    @yesterdays_list = List.find(:yesterday)
    @todays_list = List.find(:today)
    @tomorrows_list = List.find(:tomorrow)
  end
end
