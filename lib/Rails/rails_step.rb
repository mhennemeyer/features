class RailsStep < Step
  def first_part
    body.gsub(/\s+/,"_").gsub(/'[^']*'/, "__").remove_invalid_chars.sub(/./) do |first_char|
      first_char.downcase
    end
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
