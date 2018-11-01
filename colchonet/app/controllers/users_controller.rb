class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'Cadastro criado com sucesso!' 
      redirect_to @user 
    else
      render action: :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update user_params
      flash[:notice] = 'Cadastro atualizado com sucesso!' 
      redirect_to @user
    else
      render action: :edit 
    end
  end  
  
  private

  def user_params
    params.require(:user).permit(:email,:full_name,:location,
    :password,:password_confirmation,:bio)
  end
end