class LogLineParser
  def initialize(line)
    @line = line
  end

  def message
    find_string = ']: '
    idx = @line.index(find_string) + find_string.size
    @line[idx..].strip()
  end

  def log_level
    case @line[1]
    when 'I'
      return 'info'
    when 'W'
      return 'warning'
    when 'E'
      return 'error'
    else
      raise StandardError
    end
  end

  def reformat
    "#{message()} (#{log_level()})"
  end
end
