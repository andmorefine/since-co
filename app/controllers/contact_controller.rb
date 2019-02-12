class ContactController < ApplicationController

  def new
    @contact = Contact.new()
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.save
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
