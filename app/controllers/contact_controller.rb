class ContactController < ApplicationController

  CHATWORK_ROOM = 140834301

  def new
    @contact = Contact.new()
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.save
    message = "[info][title]モゲーーー[/title]お問い合わせがあったよ [/info]"
    Chatwork::MessageService.new(room_id: CHATWORK_ROOM, body: message).create
    Github::IssueService.new(title: contact_params[:subject], body: contact_params[:body]).create
    redirect_to thanks_contact_index_path
  end

  def thanks
  end

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
