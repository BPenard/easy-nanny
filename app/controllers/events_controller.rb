class EventsController < ApplicationController

  def index
    @events = policy_scope(Event)
    render 'welcome'
  end
end
