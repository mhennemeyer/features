class Feature
  
  attr_reader :scenarios, :scenario_keyword,
              :title, :body, :parent, :parser,
              :given_scenario_keyword, :keyword,
              :follow_up_keyword
  
  def initialize(hash={})
    @title                  = hash[:title]
    @body                   = hash[:body]
    @parent                 = hash[:parent]
    @keyword                = hash[:keyword] || "Feature:"
    @scenario_keyword       = hash[:scenario_keyword] || "Scenario:"
    @given_scenario_keyword = hash[:given_scenario_keyword] || "GivenScenario:"
    @follow_up_keyword      = hash[:follow_up_keyword] || "And"
    
    raise "No title given" unless title
    raise "No body given" unless body
  end
  
  def story
    body.split(/#{scenario_keyword}/)[0].split(/#{keyword}\s#{title}/).join(" ").strip
  end
  
  def story_html
    story.split("\n").join(" <br />")
  end
  
  
end