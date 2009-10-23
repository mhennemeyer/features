class ObjcScenario < Scenario
  def verify_status(results="")
    test_case_name = parent.test_case_name
    #Test Case '-[SayHelloTest testWithABlankObject]' failed (0.001 seconds).
    # ignore "... started."
    results =~ /Test\sCase\s'-\[#{test_case_name}\s#{test_name}\]'\s(passed|failed)/
    match = $1
    if match =~ /failed/
      @passed = false
    elsif match =~ /passed/
      @passed = true
    else
      raise "Can't read results File"
    end
  end
  
  def parse_lines
    lines.map {|l| ObjcStep.new({:body => l}).aggregate!}
  end
  
  def to_s
    <<-END
    -(void) #{test_name}
    {
        #{steps.map {|s| s.to_s}.join(" ")}
    }
    END
  end
  
  def test_name
    "test#{title.remove_invalid_chars.split(/\s+/).map {|w| w.capitalize}.join('')}"
  end
end