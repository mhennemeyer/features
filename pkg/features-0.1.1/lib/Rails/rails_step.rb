class RailsStep < Step
  attr_reader :message
  
  attr_reader :body, :parent
  def initialize(hash)
    @body   = hash[:body]
    @parent = hash[:parent]
    raise "No body given" unless body
  end
  
  def to_html
    s = <<-END
    <h3 class="step">#{body}</h3>
    END
    s.strip
  end
  
  def aggregate!
    @message = first_part + args_string
    self
  end
  
  def first_part
    body.gsub(/\s+/,"_").gsub(/'[^']*'/, "__").remove_invalid_chars.sub(/./) do |first_char|
      first_char.downcase
    end
  end
  
  def has_args?
    !args.empty?
  end
  
  def args
    @args ||= body.scan(/'([^']*)'/).map {|a| a[0]}
  end
  
  def args_string
    if has_args?
      "(" + args.map {|a| '"' + a.to_s + '"'}.join(", ") + ")"
    else
      ""
    end
  end
  
  def to_s
    message
  end
  
  def parameter_string
    if has_args?
      s = "(arg"
      (args[1..args.length] || []).each_with_index do |a, i|
        s << ", arg#{i+2}"
      end
      s + ")"
    else
      ""
    end
  end
end
