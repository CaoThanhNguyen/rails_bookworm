class BooksController < ApplicationController
    before_action :required_login
    def index 
        @user = User.find(id=session[:user_id])
        if Review.all.length >= 3
            all_reviews = Review.order(:created_at).reverse_order.all
            # TODO: Refactor code
            @recent_reviews = all_reviews.first(3)
            other_reviews = all_reviews.select{|review| @recent_reviews.include?(review) == false}
            @other_books = []
            for review in other_reviews
                if !@other_books.include?(review.book)
                    @other_books.append(review.book)
                end
            end
            # @other_book = @other_books.uniq
        else
            @recent_reviews = Review.order(:created_at).reverse_order.all
            @other_books = []
        end
        render "index"
    end

    def show
        @book = Book.find(id=params[:book_id])
        if @book
            @reviews = @book.reviews
            render "show"
        else
            flash[:errors] = "Book was not found!"
            redirect("/books")
        end
    end

    def new
        @authors = Author.all
        render "new"
    end

    def create
        bookInfo = allowed_book_params
        existing_author = bookInfo.fetch(:existing_author)
        if !existing_author.empty?
            author_name = existing_author
        else
            author_name = bookInfo.fetch(:new_author)
        end
        @user = User.find(id=session[:user_id])
        @author = Author.new(name:author_name)
        if @author.save
            @book = Book.new(title: bookInfo.fetch(:title), author:@author, user:@user)
            if @book.save
                @review = Review.create(review: bookInfo.fetch(:review), rating: bookInfo.fetch(:rating),
                                book:@book, user:@user)
                if @review.save
                    redirect_to("/books/#{@book.id}") 
                else
                    # delete @book. Do not allow any book without review
                    @book.destroy
                    flash_errors @review
                    redirect_to(:back)
                end
            else
                flash_errors @book
                redirect_to(:back)
            end
        else
            flash_errors @author
            redirect_to(:back)
        end
    end
end
