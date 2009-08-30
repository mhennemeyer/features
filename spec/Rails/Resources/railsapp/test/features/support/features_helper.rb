current_dir = File.dirname(File.expand_path(__FILE__))
require current_dir + "/../../test_helper.rb"


module Steps
  def given_Hello_World
    assert true
  end
  
  def when_i_go_to___(url)
    get url
  end
  
  def then_i_should_see___(string)
    assert_match(/#{string}/, response.body)
  end
end


require current_dir + "/features_test_case_class.rb"