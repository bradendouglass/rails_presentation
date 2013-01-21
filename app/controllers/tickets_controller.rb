class TicketsController < ApplicationController
  respond_to :json
  def index
    respond_with Ticket.all
  end

  def create
    respnd_with Ticket.create
  end
  
  private
  def urgent_mailer(ticket, user)
    @ticket = ticket
    TicketMailer.urgent_email(@ticket, user).deliver if @ticket.urgency >= 7
  end
end
