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

  def month_events

    event_types = ["Congés", "RTT"]

    @contract = Contract.find(params[:contract_id])
    @new_event = Event.new
    # @new_event.contract = @contract
    date = Date.parse(params[:start_date])
    start_date = Date.new(date.year, date.month, 1)
    @events = @contract.events.where(type: event_types, start_date: start_date.beginning_of_month..start_date.end_of_month)
    authorize @contract
    authorize @events
  end

  def payslip_creation_create

    @event = Event.new(event_params)

    @event.contract = Contract.find(params[:contract_id].to_i)
    @event.type = params[:type]
    @event.child = @event.contract.children.first
    authorize @event

    if @event.save!
      @new_event = Event.new

      redirect_to contract_month_events_path(@event.contract, start_date: Date.today), status: :see_other
      # redirect_to welcome_path, status: :see_other
    else
      render :index, status: :unprocessable_entity
    end

  end

  private





  def event_params
    params.require(:event).permit(:contract_id, :type, :description, :start_date, :photo, :child_id)
  end
end
