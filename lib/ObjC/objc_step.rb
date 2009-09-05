class ObjcStep < Step
  def first_part
    body.gsub(/\s+/,"_").gsub(/'[^']*'/, "__").remove_invalid_chars
  end
  
  def args_string
    if has_args?
      ([":@\"#{args[0]}\""] + 
      (args[1..args.length] || []).map { |a| "arg:@\"#{a}\"" }).join(" ")
    else
      ""
    end
  end
  
  def to_s
    "[self #{message}];"
  end
  
  def parameter_string
    if has_args?
      s = ":(NSString *)arg "
      (args[1..args.length] || []).each_with_index do |a, i|
        s << "arg:(NSString *)arg#{i+2} "
      end
      s
    else
      ""
    end
  end
  
  def to_ocmethod
    <<-END
-(void) #{first_part + parameter_string}
{
  
}
    END
  end
end
