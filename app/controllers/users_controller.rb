class UsersController < ApplicationController
  respond_to :html, :js
  def index
    @users = User.recent
    respond_with(@users)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      respond_with(@user) do |format|
        format.html { redirect_to users_path, 
          :notice => "Huzzah, #{@user.name} successfully added"}
      end
    else
      render :new, :error => "Something went way wrong, please try again"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      respond_with(@user) do |format|
        format.html { redirect_to @user, :notice => "Update Successful" }
      end
    else
      render :edit, :error => "Something went haywire, please try again"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_with do |format| 
      format.html {redirect_to users_path, :notice => "User punted OUTA here!"}
    end
  end
end
