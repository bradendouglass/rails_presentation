class TicketMailer < ActionMailer::Base
  default from: "admin@ticketer.com"
  def urgent_email(ticket, user)
    @ticket = ticket
    @user = user
    mail(to: @user.email,
        subject: %q{An Excalated Ticket Has Been Assigned To You})

  end
end
