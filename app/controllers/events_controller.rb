class EventsController < ApplicationController

before_action :set_event, :only => [ :show, :edit, :update, :destroy]

# def index
#   @events = Event.all
# end
def index
  @events = Event.page(params[:page]).per(5)
end

def new
	@event = Event.new
end

# def create
#   @event = Event.new(params[:event])
#   @event.save

#   redirect_to :action => :index
# end

def show
  # @event = Event.find(params[:id])
  # @event = Event.find(params[:id])
  @page_title = @event.name
end

def edit
  # @event = Event.find(params[:id])
end

# def update
#   # @event = Event.find(params[:id])
#   @event.update_attributes(event_params)

#   redirect_to :action => :show, :id => @event
# end

def update
	flash[:notice] = "event was successfully updated"
  if @event.update_attributes(event_params)
    redirect_to :action => :show, :id => @event
  else
    render :action => :edit
  end
end


def destroy
	flash[:alert] = "event was successfully deleted"
  # @event = Event.find(params[:id])
  @event.destroy

  redirect_to :action => :index
end

# def create
#   @event = Event.new(event_params)
#   @event.save

#   redirect_to :action => :index
# end
# flash[:notice] = "event was successfully created"

def create
	flash[:notice] = "event was successfully created"
  @event = Event.new(event_params)
  if @event.save
    redirect_to :action => :index
  else
    render :action => :new
  end
end

private

def set_event
  @event = Event.find(params[:id])
end

def event_params
  params.require(:event).permit(:name, :description)
end

end
