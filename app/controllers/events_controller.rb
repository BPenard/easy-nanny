class EventsController < ApplicationController
  def index
    @events = policy_scope(Event)
    start_date = params.fetch(:start_date, Date.today).to_date

    # @events = @events.where("start_date >= ?", start_date.beginning_of_week)
  end

  def new
    @event = Event.new
    # @nannies = [[1, "Nannie 1"], [2, "Nannie 2"]]
    # authorize @nannies
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.contract = Contract.find(params[:event][:contract_id].to_i)
    @event.child = Child.find(params[:event][:child].to_i)
    authorize @event

    if @event.save!
      redirect_to welcome_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def event_params
    params.require(:event).permit(:contract_id, :type, :description, :child_id, :start_date, :photo)
  end
end


## 1 faire resortir chaque jours
## faire un fetch avec une date en dur
## mettre à jour la méthode pour récupérer les éléments
## lorsqu'on met à jour les événements via une partial qui est mise à jour
