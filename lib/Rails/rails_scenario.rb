class RailsScenario < Scenario
  def verify_status(results="")
    test_case_name = parent.test_case_name
    
    # 2) Failure:
    # test_AnotherFailingOne(FeatureTest) [/test/integration/feature_test.rb:16]:
    # <false> is not true.
    
    result = (results =~ /^\s*#{test_name}\(#{test_case_name}\)/)
    @passed = result ? false : true
  end
  
  def parse_lines
    lines.map {|l| RailsStep.new({:body => l}).aggregate!}
  end
  
  def to_s
    <<-END
def #{test_name}
  #{steps.map {|s| s.to_s}.join("; ")}
end
    END
  end
  
  def test_name
    "test_#{title.remove_invalid_chars.split(/\s+/).map {|w| w.capitalize}.join('')}"
  end
end