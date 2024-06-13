class EventsController < ApplicationController
  def index
    @events = policy_scope(Event).order(start_date: :asc).includes(child: [photo_attachment: :blob])
    @new_event = Event.new
    start_date = params.fetch(:start_date, Date.today).to_date

    @events = @events.where("start_date >= ? AND start_date <= ?", start_date.beginning_of_week, start_date.end_of_week)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: { content: (render_to_string partial: '/events/week-events', formats: :html, locals: {events: @events}, layout: false) } }
    end
  end

  def create
    @event = Event.new(event_params)
    @event.contract = Contract.find(params[:event][:contract_id].to_i)
    @event.type = params[:type]
    @event.child = Child.find(params[:event][:child_id].to_i)
    authorize @event

    if @event.save!
      @new_event = Event.new
      redirect_to welcome_path, status: :see_other
    else
      render :index, status: :unprocessable_entity
    end
  end

  def event_params
    params.require(:event).permit(:contract_id, :type, :description, :start_date, :photo, :child_id)
  end
end
