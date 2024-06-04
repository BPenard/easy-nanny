class EventsController < ApplicationController

  def index
    @events = policy_scope(Event)
    render 'welcome'
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.nanny_id = current_user.nanny.id
    @event.children_id = current_user.children.id

    if @event.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def event_params
    params.require(:event).permit(:nanny_id, :child_id, :date, :type)
  end
end
