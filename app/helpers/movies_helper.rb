module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def link_to_movie_title(sort_by)
    link_to 'Movie Title', movies_path(sort_by: 'title'), id: 'title_header'
  end
  
  def link_to_release_date(sort_by)
    link_to 'Release Date', movies_path(sort_by: 'release_date'), 
              id: 'release_date_header'
  end
  
end
