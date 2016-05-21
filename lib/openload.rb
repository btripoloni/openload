require 'httparty'
require 'ostruct'

class OpenLoad
  @api_url = "https://api.openload.co/1"

  # Create a new instace using the api-login and the api-key (both are optional)
  def initialize(login = nil, key = nil)
    @api_login = login
    @api_key   = key
  end

  def acount_info
    if is_logged?
      get_a_request_and_return_in_a_struct("/account/info?login=#{@api_login}&key=#{@api_key}")
    else
      raise "You need to insert a login and a key to use this method!"
    end
  end

  #Get the ticket to download a file
  def download_ticket(file)
    get_a_request_and_return_in_a_struct("/file/dlticket?file=#{file}#{login_parameter}#{key_parameter}")
  end

  # Get the download link from a ticket
  def download_link(file, ticket, captcha_response = nil)
    get_a_request_and_return_in_a_struct("/file/dl?file=#{file}&ticket=#{ticket}#{http_parameter('captcha_response', captcha_response)}")
  end

  # This method return the info of a file
  # Warning: this method rertuns a hash
  def file_info(file)
    response = get_a_request("/file/info?file=#{file}#{login_parameter}#{key_parameter}")
    JSON.parse(response)
  end

  # This method return a link that you can make uploads.
  # Warning: this links expire in a few hours, always check the .
  def upload_link(folder = nil, sha1 = nil, httponly = nil)
    get_a_request_and_return_in_a_struct("/file/ul#{login_parameter(true)}#{key_parameter}#{http_parameter('folder', folder)}#{http_parameter('sha1', sha1)}#{http_parameter('httponly', httponly)}")
  end

  # This method make a upload of a link from the web
  # Remember: You need a login and key api to use this method.
  def remote_upload(url, folder = nil , headers = nil)
    if is_logged?
      get_a_request_and_return_in_a_struct("/remotedl/add#{login_parameter(true)}#{key_parameter}#{http_parameter('url', url)}#{http_parameter('folder',folder)}#{http_parameter('headers', headers)}")
    else
      raise "You need a login and a api key to make remote uploads!"
    end
  end

  # This method cheks the status of the remote uploads.
  def check_remote_upload_status(id = nil, limit = nil)
    get_a_request_and_return_in_a_struct("/remotedl/status#{login_parameter(true)}#{key_parameter}#{http_parameter('limit', limit)}#{http_parameter('id', id)}")
  end

  # This method return a list of all folders.
  # You need a login and api kei
  # This method return returns a hash
  def folder_list(folder = nil)
    response = get_a_request("/file/listfolder?login=#{@api_login}&key=#{@api_key}#{http_parameter('folder', folder)}")
    JSON.parse(response)
  end

  # This method convert files to stream format (mp4/h.264)
  def convert_to_stream(file)
    get_a_request_and_return_in_a_struct("/file/convert?login=#{@api_login}&key=#{@api_key}&file=#{file}")
  end

  def show_converted_files(folder = nil)
    get_a_request_and_return_in_a_struct("/file/runningconverts?login=#{@api_login}&key=#{@api_key}}#{http_parameter('folder',folder)}")
  end

  def get_splash_image(file)
    get_a_request_and_return_in_a_struct("/file/getsplash?login=#{@api_login}&key=#{@api_key}&file=#{file}")
  end

  private
  def get_a_request(path)
    HTTParty.get("#{api_url}#{path}").body
  end

  def http_parameter(name, value, first_parameter = false)
    "#{'?' if first_parameter}#{'&' unless first_parameter}#{name}=#{value}" if value
  end

  def login_parameter(first_parameter = false)
    http_parameter('login', @api_login, first_parameter)
  end

  def key_parameter()
    http_parameter('key', @api_key)
  end

  def is_logged?
    @api_key && @api_login
  end

  def get_a_request_and_return_in_a_struct(req)
    response = get_a_request(req)
    data_hash = JSON.parse(response)
    OpenStruct.new(data_hash)
  end
end
