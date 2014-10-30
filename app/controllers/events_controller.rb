class EventsController < ApplicationController

before_action :set_event, :only => [ :show, :edit, :update, :destroy]

before_action :authenticate_user!


def index
  sort_by = (params[:order] == 'name') ? 'name' : 'created_at'
  @events = current_user.events.order(sort_by).page(params[:page]).per(5)

  @event = Event.new

  Rails.logger.debug("event: #{@event.inspect}") #check events

  respond_to do |format|
    format.html # index.html.erb
    format.xml { render :xml => @events.to_xml }
    format.json { render :json => @events.to_json }
    format.atom { @feed_title = "My event list" } # index.atom.builder
  end
end

#def new
#	@event = Event.new
#end

def show
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
  @event.destroy

  redirect_to events_url
end

def create
  
	flash[:notice] = "event was successfully created"
  @event = Event.new(event_params)

  @event.user = current_user


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

def dashboard
    @event = Event.find(params[:id])
end

private

def set_event
  @event = Event.find(params[:id])
end

def event_params
  params.require(:event).permit(:name, :description, :category_id, :location_attributes => [:name], :group_ids => [])
end

end
