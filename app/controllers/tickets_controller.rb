class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
  end

  def new
    @user = User.find(params[:user_id])
    @ticket = @user.tickets.new
  end

  def create
    @user = User.find(params[:user_id])
    @ticket = @user.tickets.new(params[:ticket])
    if @ticket.save
      redirect_to user_path(@user), :notice => 'Ticket created'
    else
      render :new, :error => 'Error occured while creating the ticket, sorry'
    end
  end
end
