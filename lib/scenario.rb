class Scenario
  attr_reader :steps, :lines, :given_scenario_keyword,
              :title, :body, :parent, :passed, :follow_up_keyword
              
  def initialize(hash)
    @title  = hash[:title]
    @body   = hash[:body]
    @parent = hash[:parent]
    @given_scenario_keyword = hash[:given_scenario_keyword] || "GivenScenario:"
    @follow_up_keyword = hash[:follow_up_keyword] || "And"
    
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
  
  def collect_steps
    if has_given_scenarios?
      @body = expand_given_scenarios_in_body.strip
    end

    if has_follow_ups?
      @body = expand_follow_ups_in_body.strip
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
  
  def expand_follow_ups_in_body
    lines = body.split("\n")
    new_lines = []
    step = ""
    for line in lines
      if line =~ follow_up_line_exp
        args = line.sub(/^\s*#{follow_up_keyword}\s*/, "").split("|").reject {|arg| arg =~ /\A\s*\Z/ }.map {|arg| "'" + arg.strip + "'"}
        arr  = step.split("'").reject {|elt| elt =~ /\A\s*\Z/ }
        offset = (step =~ /\A\s*'/) ? 0 : 1
        new_step = ""
        
        arr.each_with_index do |elt, index|
          if index % 2 == offset
            new_step << args[(index - offset) / 2]
          else
            new_step << elt
          end
        end
        new_lines << new_step 
      else
        new_lines << line
        step = line
      end
    end
    new_lines.join("\n")
  end
  
  def given_scenario_line_exp
    /#{given_scenario_keyword}(.*)/
  end
  
  def has_given_scenarios?
    !!(body =~ given_scenario_line_exp)
  end
  
  def follow_up_line_exp
    /#{follow_up_keyword}\s*\|(.*)\s*\|\s*/
  end
  
  def has_follow_ups?
    !!(body =~ follow_up_line_exp)
  end
end