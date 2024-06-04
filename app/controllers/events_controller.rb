class EventsController < ApplicationController
  def index
    @events = Event.all
    render 'welcome'
  end
end
