class MessagesController < ApplicationController
  before_filter :redirect_unless_logged_in

  def new
    @meetup = Meetup.where(id: params[:meetup_id]).first
    @message = Message.new
    render :"messages/new", :layout => true
  end

  def create
    p params
    meetup = Meetup.find(params[:meetup_id])
    message = Message.new
    message.text = params[:message][:text]
    message.user = current_user
    message.user_id = current_user.id
    if message.save
      meetup.messages << message
    end
    redirect_to user_meetup_path(current_user, meetup)
  end
end
