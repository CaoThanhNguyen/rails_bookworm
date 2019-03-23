class ReviewsController < ApplicationController
    before_action :required_login
    def create 
        @user = User.find(id=session[:user_id]) 
        @book = Book.find(id=params[:book_id])
        @review = Review.new(allowed_review_params)
        @review.user = @user
        @review.book = @book
        if !@review.save
            flash_errors(@review)
        end
        redirect_to("/books/#{@book.id}") 
    end
    def destroy
        Review.find(id=params[:review_id]).destroy
        redirect_to(:back)
    end
end
