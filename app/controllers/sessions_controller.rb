class SessionsController < ApplicationController
    
    def new
    end
    
    def create
        @user = User.find_by(username: params[:username])
        if !!@user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            render json: {"msg": "Bienvenid- %s" %[@user.name], "status":200}
        else
            message = "Usuario o contraseña erronea"
            render json: {"msg": message}
        end
    end
    def GoogleAuth
        user_info = request.env["omniauth.auth"]
        user =  User.find_by_email(user_info["info"]["email"])
        if user
            flash[:alert] = 'Bienvenido!'
            session[:user_id] = user.id
            redirect_to root_path
            return
        end
        
        @user = User.new(name: user_info["info"]["name"], email: user_info["info"]["email"], image: user_info["info"]["image"])
        if @user.save
            flash[:notice] = 'Hemos registrado tu usuario!'
            session[:user_id] = @user.id
            redirect_to root_path
        else
            flash[:alert] = 'ups! algo falló, prueba registrarte directamente!'
            redirect_to auth_signup_path
        end
    end
    def destroy_session
        flash[:notice] = 'Sesión terminada'
        session[:user_id] = nil
        redirect_to root_path
    end

end
