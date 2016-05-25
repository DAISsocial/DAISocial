class Request
  def self.create_request(type)
    case type
    when 'check_request'
      return CheckRequest.new
    when 'search_request'
      return SearchRequest.new
    else
      return #return null
    end
  end
end