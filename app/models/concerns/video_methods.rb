# app/models/concerns/video_methods.rb
module VideoMethods
  extend ActiveSupport::Concern

  def formatted_duration
    if iso8601_duration_format?
      iso8601_duration_to_human_readable(self.duration)
    else
      self.duration
    end
  end

  def duration_category
    total_seconds = if iso8601_duration_format?
                      iso8601_duration_to_seconds(self.duration)
                    else
                      human_readable_duration_to_seconds(self.duration)
                    end

    if total_seconds < 4 * 60
      'short'
    elsif total_seconds <= 20 * 60
      'medium'
    else
      'long'
    end
  end

  private

  def iso8601_duration_format?
    self.duration.start_with?('PT')
  end

  def iso8601_duration_to_human_readable(duration)
    match = /PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?/.match(duration)
    hours = match[1].to_i
    minutes = match[2].to_i
    seconds = match[3].to_i

    result = []
    result << "#{hours} hours" if hours > 0
    result << "#{minutes} minutes" if minutes > 0
    result << "#{seconds} seconds" if seconds > 0
    result.join(", ")
  end

  def iso8601_duration_to_seconds(duration)
    match = /PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?/.match(duration)
    hours = match[1].to_i
    minutes = match[2].to_i
    seconds = match[3].to_i
    (hours * 3600) + (minutes * 60) + seconds
  end

  def human_readable_duration_to_seconds(duration)
    match = /(?:(\d+) hours)?(?:(\d+) minutes)?(?:(\d+) seconds)?/.match(duration)
    hours = match[1].to_i
    minutes = match[2].to_i
    seconds = match[3].to_i
    (hours * 3600) + (minutes * 60) + seconds
  end
end
