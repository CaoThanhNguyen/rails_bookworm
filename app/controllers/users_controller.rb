class UsersController < ApplicationController
    before_action :required_login, except: [:create]
    def create
        # @user = User.create(username:params[:username], email:params[:email], 
        #         password:params[:password], password_confirmation:params[:password_confirmation])
        @user = User.create(allowed_user_params)
        if @user.valid?
            session[:user_id] = @user.id
            redirect_to("/books")
            return
        end
        flash_errors(@user)
        redirect_to("/")
    end

    def show 
        @user = User.find(id=params[:user_id])
        @total_reviews = @user.reviews.length
        @reviewed_books = @user.reviewed_books.uniq
        render "show"
    end

    def edit
        if is_allowed(params[:user_id].to_i)
            @user = User.find(id=params[:user_id])
            render "edit"
        end
    end

    def update
        if is_allowed(params[:user_id].to_i)
            isSuccess = User.find(id=params[:user_id]).update(allowed_user_params)
            if isSuccess
                redirect_to("/users/#{params[:user_id]}")
            else
                flash[:errors] = ["Invalid input"]
                redirect_to("/users/#{params[:user_id]}/edit")
            end
        end
    end

    def destroy
        if is_allowed(params[:user_id].to_i)
            User.find(id=params[:user_id]).destroy
            session[:user_id] = nil
            redirect_to("/")
        end
    end

end
