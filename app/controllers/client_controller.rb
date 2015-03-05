class ClientController < ApplicationController
  before_filter :authenticate_user!


  def index
  	@clients = Client.all
  end


  def new
    @client = Client.new
  end


  def create
    @client = Client.new(secure_params)
    if @client.save
      redirect_to client_index_path,  :notice => "Client Created!"
    else
      render :action => 'new'
    end
  end


  def edit
  	@client = Client.find(params[:id])
  end


  def update
  	 @client = Client.find(params[:id])
    if @client.update_attributes(secure_params)
      redirect_to client_index_path, :notice => "Client updated."
    else
      render :action => 'edit'
    end
  end


  def destroy
	client = Client.find(params[:id])
	client.destroy
	redirect_to client_index_path, :notice => "Client deleted."
  end


  def show
  end


  def secure_params
    params.require(:client).permit(:name, :description)
  end

end
