class RailsFeature < Feature
  def parse_scenarios(klass=RailsScenario)
    title_body_arr = Parser.title_and_body_by_keyword_from_string({
      :string => body,
      :keyword => scenario_keyword
    })
    @scenarios = title_body_arr.map {|hash| klass.new(hash.update({
      :parent => self,
      :given_scenario_keyword => given_scenario_keyword,
      :follow_up_keyword => follow_up_keyword
    }))}
    @scenarios.each {|scenario| scenario.collect_steps}
    self
  end
  
  def to_s
    <<-END
class #{test_case_name} < FeaturesTestCaseClass
  #{scenarios.map {|s| s.to_s}.join("\n")}
end
    END
  end
  
  def to_html
    <<-END
    <div class="feature">
      <h2 class="feature_title">#{keyword} #{title}</h2>
      <p class="story">
        #{story_html}
      </p>
      #{scenarios.map {|s| s.to_html }.join(" \n")}
    </div>
  END
  end
  
  def test_case_name
    "#{title.remove_invalid_chars.split(/\s+/).map {|w| w.capitalize}.join('')}Test"
  end
end