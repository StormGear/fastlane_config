# pubspec_path = '../pubspec.yaml'
pubspec_path = File.expand_path('../../pubspec.yaml', __FILE__)

# Read the file into an array of lines
lines = File.readlines(pubspec_path)

# Find the line containing the version and update it
lines.map! do |line|
  if line.strip.start_with?('version:')
    if line =~ /(\d+)\.(\d+)\.(\d+)\+(\d+)/
      major, minor, patch, build = $1.to_i, $2.to_i, $3.to_i, $4.to_i
      build += 1
      line = "version: #{major}.#{minor}.#{patch}+#{build}\n"
    end
  end
  line
end

# Write the updated lines back to the file
File.open(pubspec_path, 'w') { |file| file.puts(lines) }