module SearchHelper
  # fix the size of displayed page numbers (for simplicity)
  PAGE_NUMBERS_SIZE = 10

  def url_for_page(page)
    search_path(search_params_for_page page)
  end

  def search_params_for_page(page)
    {search: params.fetch(:search).merge(page: page)}
  end

  def current_page_numbers
    current_page = @pagination_info[:page]
    base = (current_page - 1) / PAGE_NUMBERS_SIZE 
    mod = (current_page - 1) % PAGE_NUMBERS_SIZE
    first = base * PAGE_NUMBERS_SIZE + 1
    
    last = first + PAGE_NUMBERS_SIZE - 1
    if last > @pagination_info[:pages]
      last = @pagination_info[:pages]
    end
    
    (first..last).to_a
  end

end
