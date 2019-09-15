# frozen_string_literal: true

class ContactController < ApplicationController
  CHATWORK_ROOM = 140_834_301

  def new
    @contact = Contact.new
  end

  def create
    contact = Contact.new(contact_params)
    contact.save
    message = "[info][title]#{contact[:subject]}[/title]#{contact[:body]}[/info]"
    Chatwork::MessageService.new(room_id: CHATWORK_ROOM, body: message).create
    Github::IssueService.new(title: contact_params[:subject], body: contact_params[:body]).create
    NotificationMailer.send_confirm_to_user(contact).deliver_later
    redirect_to thanks_contact_index_path
  end

  def thanks; end

  private

  def contact_params
    params.require(:contact).permit(
      :name,
      :email,
      :subject,
      :body
    )
  end
end
