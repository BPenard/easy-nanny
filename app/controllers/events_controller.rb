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
    @event.contract = Contract.find(params[:event][:contract_id].to_i)
    @event.child = Child.find(params[:event][:child].to_i)
    authorize @event

    if @event.save!
      raise
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def event_params
    params.require(:event).permit(:contract_id, :child_id, :date, :photo)
  end
end
