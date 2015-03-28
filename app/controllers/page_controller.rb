class PageController < ApplicationController
  def index
    render layout: false
  end

  def about
    render 'About.html'
  end

  def guides
    render 'Guides.html'
  end
end
