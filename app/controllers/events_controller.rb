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
    start_date = Date.parse(params[:start_date])
    start_date = Date.new(start_date.year, start_date.month, 1)
    end_date = start_date.next_month.prev_day
    payslip_period = { start_date:, end_date: }
    @events = @contract.events.where(type: event_types, start_date: payslip_period[start_date]..payslip_period[end_date])
    # @events = @contract.events.where(type: event_types, date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  

    authorize @contract
    authorize @events
  end

  private





  def event_params
    params.require(:event).permit(:contract_id, :type, :description, :start_date, :photo, :child_id)
  end
end
