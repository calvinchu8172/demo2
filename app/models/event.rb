class Event < ActiveRecord::Base
    validates_presence_of :name
    
    belongs_to :category

    has_one :location # 單數
    has_many :attendees # 複數

    has_many :event_groupships
    has_many :groups, :through => :event_groupships

    belongs_to :user

end