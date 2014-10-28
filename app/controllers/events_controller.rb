class EventsController < ApplicationController

before_action :set_event, :only => [ :show, :edit, :update, :destroy]

# def index
#   @events = Event.all
# end
def index
  @events = Event.page(params[:page]).per(5)

  Rails.logger.debug("event: #{@event.inspect}") #check events

  respond_to do |format|
    format.html # index.html.erb
    format.xml { render :xml => @events.to_xml }
    format.json { render :json => @events.to_json }
    format.atom { @feed_title = "My event list" } # index.atom.builder
  end
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
  # @page_title = @event.name
@event = Event.find(params[:id])
  respond_to do |format|
    format.html { @page_title = @event.name } # show.html.erb
    format.xml # show.xml.builder
    format.json { render :json => { id: @event.id, name: @event.name }.to_json }
  end

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
    # redirect_to :action => :show, :id => @event
    redirect_to event_url(@event)
  else
    render :action => :edit
  end
end


def destroy
	flash[:alert] = "event was successfully deleted"
  # @event = Event.find(params[:id])
  @event.destroy

  # redirect_to :action => :index
  redirect_to events_url
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
    # redirect_to :action => :index
    redirect_to events_url
  else
    render :action => :new
  end
end

def search
    @events = Event.where( [ "name like ?", "%#{params[:keyword]}%" ]).page(params[:page]).per(5)
    render :action => :index
end

private

def set_event
  @event = Event.find(params[:id])
end

def event_params
  params.require(:event).permit(:name, :description, :category_id, :location_attributes => [:name], :group_ids => [])
end

end
