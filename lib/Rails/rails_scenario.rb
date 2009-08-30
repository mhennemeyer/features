class RailsScenario < Scenario
  attr_reader :steps, :lines, :given_scenario_keyword,
              :title, :body, :parent, :passed
              
  def initialize(hash)
    @title  = hash[:title]
    @body   = hash[:body]
    @parent = hash[:parent]
    @given_scenario_keyword = hash[:given_scenario_keyword] || "GivenScenario:"
    
    raise "No title given" unless title
    raise "No body given" unless body
  end
  
  def keyword
    parent.scenario_keyword
  end
  
  def to_html
    <<-END
    <div class="scenario #{passed? ? "passed" : "failed"}">
      <h2 class="scenario_title">#{keyword} #{title}</h2>
      #{steps.map {|s| s.to_html}.join(" \n")}
    </div>
    END
  end
  
  def passed?
    !!@passed
  end
  
  def verify_status(results="")
    test_case_name = parent.test_case_name
    
    # 2) Failure:
    # test_AnotherFailingOne(FeatureTest) [/test/integration/feature_test.rb:16]:
    # <false> is not true.
    
    result = (results =~ /^\s*#{test_name}\(#{test_case_name}\)/)
    @passed = result ? false : true
  end
  
  def collect_steps
    
    if has_given_scenarios?
      @body = expand_given_scenarios_in_body.strip
    end
    
    
    @lines = body.split(/\n+/).map {|s| s.strip}
    raise "No Steps found" if lines.empty?
    
    @steps = parse_lines
    self
  end
  
  def expand_given_scenarios_in_body
    raise "No associated Feature" unless parent 
    raise "Associated Feature has no Scenarios" unless parent.scenarios
    body.gsub(/#{given_scenario_keyword}(.*)/) do |m|
      existing_scenario = parent.scenarios.detect {|s| s.title == $1.strip }
      existing_scenario ? existing_scenario.body.strip : ""
    end
  end
  
  def parse_lines
    lines.map {|l| RailsStep.new({:body => l}).aggregate!}
  end
  
  def has_given_scenarios?
    !!(body =~ /#{given_scenario_keyword}(.*)/)
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