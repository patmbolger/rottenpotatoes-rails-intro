class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    if @sort_by = params[:sort_by]
      session[:sort_by] = @sort_by
    else
      @sort_by = session[:sort_by]
    end
    if params[:ratings]
      @filtered_ratings = params[:ratings].keys
      session[:filtered_ratings] = @filtered_ratings
    elsif session[:filtered_ratings]
      flash.keep
      # Create hash of filtered ratings for adding to params[]
      ratings_hash = session[:filtered_ratings].map {|r| [r, 1]}.to_h
      redirect_to movies_path(ratings: ratings_hash,
                              sort_by: @sort_by) and return
    else
      @filtered_ratings = @all_ratings
      session[:filtered_ratings] = @filtered_ratings
    end
    @movies = Movie.where(rating: @filtered_ratings).order(@sort_by)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
