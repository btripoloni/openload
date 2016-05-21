require 'httparty'
require 'ostruct'

class openload
  @api_url = "https://api.openload.co/1"

  # Create a new instace using the api-login and the api-key (both are optional)
  def initialize(login, key)
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
    request = get_a_request("/file/dlticket?file=#{file}&login=#{@api_login}&key=#{@api_key}") if @api_key && @api_login
    request = get_a_request("/file/dlticket?file=#{file}") unless @api_key && @api_login
    data_hash = JSON.parse(request)
    OpenStruct.new(data_hash)
  end

  # Get the download link from a ticket
  def download_link(file, ticket, captcha_response)
    request = get_a_request("/file/dl?file=#{file}&ticket=#{ticket}&captcha_response=#{captcha_response}") if captcha_response
    request = get_a_request("/file/dl?file=#{file}&ticket=#{ticket}") unless captcha_response
    data_hash = JSON.parse(request)
    OpenStruct.new(data_hash)
  end

  # Get the download Link without ticket
  def download_link_with_ticket(file)
    ticket = get_download_ticket(file)
    get_download_link(file, ticket.response.ticket)
  end

  # This method return the info of a file
  # Warning this method rertuns a json
  def file_info(file)
    response = get_a_request("/file/info?file=#{file}&login=#{@api_login}&key=#{@api_key}") if @api_login && @api_key
    response = get_a_request("/file/info?file=#{file}") unless @api_login && @api_key
    JSON.parse(response)
  end

  private
  def get_a_request(path)
    HTTParty.get("#{api_url}#{'/' if path[0] != '/' }#{path}").body
  end

end
