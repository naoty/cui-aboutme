class HomeController < ApplicationController
  def index
    if request.user_agent =~ /curl/
      render 'about.text'
    else
      render 'about.html'
    end
  end
end
