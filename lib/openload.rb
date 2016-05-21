require 'httparty'
require 'ostruct'

class openload
  @api_url = "https://api.openload.co/1"

  # Create a new instace using the api-login and the api-key (both are optional)
  def initialize(login = nil, key = nil)
    @api_login = login
    @api_key   = key
  end

  def acount_info
    if login && key
      request = get_a_request("/account/info?login=#{@api_login}&key=#{@api_key}")
      data_hash = JSON.parse(request)
      OpenStruct.new(data_hash)
    else
      raise "You need to insert a login and a key to use this method!"
    end
  end

  #Get the ticket to download a file
  def download_ticket(file)
    request = get_a_request("/file/dlticket?file=#{file}#{login_parameter}#{key_parameter}")
    data_hash = JSON.parse(request)
    OpenStruct.new(data_hash)
  end

  # Get the download link from a ticket
  def download_link(file, ticket, captcha_response = nil)
    request = get_a_request("/file/dl?file=#{file}&ticket=#{ticket}#{http_parameter('captcha_response', captcha_response)}")
    data_hash = JSON.parse(request)
    OpenStruct.new(data_hash)
  end

  # Get the download Link without ticket
  def download_link_with_ticket(file)
    ticket = get_download_ticket(file)
    get_download_link(file, ticket.response.ticket)
  end

  # This method return the info of a file
  # Warning this method rertuns a hash
  def file_info(file)
    response = get_a_request("/file/info?file=#{file}#{login_parameter}#{key_parameter}")
    JSON.parse(response)
  end

  private
  def get_a_request(path)
    HTTParty.get("#{api_url}#{'/' if path[0] != '/' }#{path}").body
  end

  def http_parameter(name, value)
    "&#{name}=#{value}" if value
  end

  def login_parameter()
    http_parameter('login', @api_login)
  end

  def key_parameter()
    http_parameter('key', @api_key)
  end

end
