class ClientController < ApplicationController
  def index
  	@clients = Client.all
  end

  def show
  	  @client = Client.find(params[:id])
      unless current_user.admin?
        redirect_to :back, :alert => "Access denied."
      end
  end

  def new
  end


  def edit
  	@client = Client.find(params[:id])
  end


  def create
	  @client = Client.new(secure_params)
	  if @client.save
	    redirect_to client_index_path,  :notice => "Client Created!"
	  else
	    redirect_to new_client_path, :alert => "Unable to create Client."
	  end
  end

  def update
  	 @client = Client.find(params[:id])
    if @client.update_attributes(secure_params)
      redirect_to client_index_path, :notice => "Client updated."
    else
      redirect_to client_path, :alert => "Unable to update Client."
    end
  end

  def destroy
	client = Client.find(params[:id])
	client.destroy
	redirect_to client_index_path, :notice => "Client deleted."
  end


  def secure_params
    params.require(:client).permit(:name, :description)
  end

end
