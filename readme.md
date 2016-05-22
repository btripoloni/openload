#Openload

This a gem provide a easy access to openload.co api.

``` ruby
#all of this methods returns a OpenStruct

example:
openload    = OpenLoad.new('login', 'key')
acc         = openload.account_info
email       = acc.results.email
status_code = acc.status # returns the status code too
message     = acc.msg

# Get the info about your acc
def account_info

#Get the ticket to download a file
def download_ticket(file)

# This method return the info of a file
# Warning: this method rertuns a hash
def file_info(file)

# This method return a link that you can make uploads.
# Warning: this links expire in a few hours, always check the .
def upload_link(folder = nil, sha1 = nil, httponly = nil)

# This method make a upload of a link from the web
# Remember: You need a login and key api to use this method.
def remote_upload(url, folder = nil , headers = nil)

# This method cheks the status of the remote uploads.
def check_remote_upload_status(id = nil, limit = nil)

# This method return a list of all folders.
# You need a login and api kei
# This method return returns a hash
def folder_list(folder = nil)

# This method convert files to stream format (mp4/h.264)
def convert_to_stream(file)

# Show a list with the covered files   
def show_converted_files(folder = nil)

# Get the thumbnail
def get_splash_image(file)
```


Copyright (c) 2016 Bruno Tripoloni

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
