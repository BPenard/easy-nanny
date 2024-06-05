class EventsController < ApplicationController

  def index
    @events = policy_scope(Event)
    render 'welcome'
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    # @event.contract_id = current_user.contract.id
    # @event.children_id = current_user.children.id
    authorize @event

    if @event.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def event_params
    params.require(:event).permit(:contract_id, :child_id, :date, :type)
  end
end
