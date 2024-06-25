# slack_uploader.rb

require 'http'
require 'json'

class SlackUploader
  def initialize(token)
    @token = token
  end

  def upload(file_path, channel_id, title, initial_comment)
    url = "https://slack.com/api/files.getUploadURLExternal"
    url2 = "https://slack.com/api/files.completeUploadExternal"
    file_size = File.size(file_path)
    file_name = File.basename(file_path.strip)

    # Step 1: Request upload URL
    response = HTTP.auth("Bearer #{@token}")
                   .get(url, params: {
                     filename: file_name,
                     length: file_size,
                     pretty: 1
                   })

    result = JSON.parse(response.body.to_s)
    puts "result from getUploadURLExternal: #{result}"
    puts "result from getUploadURLExternal: #{result['ok']}"
    
 

    if result['ok']
      # Step 2: Upload the file
      upload_url = result['upload_url']
      puts "upload_url: #{upload_url}"
      upload_response = HTTP.post(upload_url, form: {
        file: HTTP::FormData::File.new(file_path)
      })
      puts "status code from upload: #{upload_response.code}"

      if upload_response.code == 200
        # Step 3: Confirm the file upload
        # Prepare the files parameter
        files_param = [{ "id" => result['file_id'], "title" => title }].to_json
        response2 = HTTP.auth("Bearer #{@token}")
        .headers('Content-Type' => 'application/x-www-form-urlencoded')
        .post(url2, form: {
          files: files_param,
          channel_id: channel_id,
          initial_comment: initial_comment
        })
        puts "result from completeUploadExternal: #{response2}"
        result2 = JSON.parse(response2.body.to_s)
        if result2['ok']
            puts "File uploaded successfully to Slack"
            true
        else 
            puts "Failed to confirm the file upload: #{result2['error']}"
            false
        end
      else
        puts "Failed to upload file to Slack: #{upload_result['error']}"
        false
      end
    else
      puts "Failed to get upload URL from Slack: #{result['error']}"
      false
    end
  end

    # Helper method to get version name and code
  def get_flutter_version_info()
    pubspec = File.read("../../pubspec.yaml")
    version_line = pubspec.match(/version:\s*([\d.]+)\+([\d]+)/)
    
    if version_line
      {
        version_name: version_line[1],
        version_code: version_line[2]
      }
    else
      puts "Could not find version information in pubspec.yaml"
    end
  end


  def get_apk_path()
    # Define the base path where Flutter builds the APK
    base_path = "../../build/app/outputs/flutter-apk"
    
    # Look for the APK file
    apk_file = Dir["#{base_path}/*-release.apk"].first
    
    if apk_file.nil?
      puts "Could not find APK file in #{base_path}"
    end
    
    return apk_file
  end
end

access_token = "your_slack_app access token"

# Initialize SlackUploader
uploader = SlackUploader.new(access_token)
# Get the version name and code
version_info = uploader.get_flutter_version_info()
version_name = version_info[:version_name]
version_code = version_info[:version_code]
file_path = uploader.get_apk_path()
puts "Uploading #{file_path} to Slack"
puts "Version Name: #{version_name}, Version Code: #{version_code}"

  # Upload to Slack
success = uploader.upload(
  file_path,
  "channel_id",  # Replace with your Slack channel ID
  "New APK Build v#{version_name} (#{version_code})",
  "Here's the latest APK build. Version: #{version_name}, Build: #{version_code}"
)

if success
  puts "APK uploaded successfully to Slack"
else
  puts "Failed to upload APK to Slack[body success]"
end