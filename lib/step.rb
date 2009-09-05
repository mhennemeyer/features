class Step
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
  
  def has_args?
    !args.empty?
  end
  
  def args
    @args ||= body.scan(/'([^']*)'/).map {|a| a[0]}
  end
end
