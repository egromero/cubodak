class UsersController < ApplicationController
    
    def new
        @user = User.new
    end

    def create
        u = User.where(username: params[:user][:username]).or(User.where(email: params[:user][:email])).exists?
        if u
            render json: {"msg" => "Usuario o correo ya registrado, prueba con uno distinto."}
            return
        end
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            render json: { "msg" => "Usuario creado exitosamente", "status" => 200}
        else
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
    end

    private
    def user_params
        params.require(:user).permit(:username, :password, :email, :terms)
    end
end