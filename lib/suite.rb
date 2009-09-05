class Suite
  
  
  def parse_output_file_and_open_in_browser(file)
    results = ""
    File.open(file) do |f|
      f.readlines.each do |l|
        results << l
      end
    end
    
    html = parse_results(results).html

    %x(touch '/tmp/out.html' && echo '#{html}' > /tmp/out.html && open '/tmp/out.html' ) 
  end
  
  def parse_results_and_open_in_safari(results)
    html = parse_results(results).html
    open_in_safari(html)
  end
  
  def open_in_safari(html)
    %x(touch '/tmp/out.html' && echo '#{html}' > /tmp/out.html && open '/tmp/out.html' )
  end
  
  def parse_results(results="")
    parse
    @passed = true
    features.each do |f|
      f.scenarios.each do |s|
        s.verify_status(results)
        @passed &&= s.passed?
      end
    end
    self
  end
  
  def passed?
    @passed
  end
  
  def html
    <<-END
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
      <head>
        <style type="text/css">
        body { 
          font-family: Lucida Grande;
          background-color: #FEFEFE;
          padding: 5px;
        }
        * {-webkit-border-radius: 10px;}
        body {background-color: #EEE; -webkit-border-radius: 0px;}
        .feature { background-color: #E0E0E0;padding: 20px; margin: 20px;}
        .scenario { background-color: #EEE; padding: 20px; margin: 20px}
        .failed {border: 1px solid #C88; background-color: #B77; }
        .passed {border: 1px solid #8C8; background-color: #7B7; }
        .feature_title {font-size: 24pt; }
        .story { font-size: 18pt; padding-left: 40px;}
        #indicator { width: 100%; height: 20px; }
        #wrap { background-color: #EEE; padding: 20px }
        </style></head>
      </head>
      <body>
      <div id="wrap">
        <div id="header">
          <div id="indicator" class="#{passed? ? "passed" : "failed"}">&nbsp;</div>
          <h1 class="project_name">#{project_name}</h1>
          
        </div>
        #{features.map {|f| f.to_html }.join(" \n")}
      </div>
      </body>
    </html>
    END
  end
  
  def valid?
    unique_feature_test_case_names?
  end
  
  def unique_feature_test_case_names?
    feature_test_case_name =  features.map {|f| f.test_case_name }
    feature_test_case_name == feature_test_case_name.uniq
  end
  
  def run
    parse
    raise "Invalid: Duplicated Titles" unless valid?
    File.open(test_cases_file, "w") { |f| f.puts self }
  end
  
  def parse
    parse_features
    parse_feature_scenarios
  end
  
  def parse_feature_scenarios
    features.each do |feature|
      feature.parse_scenarios
    end
  end
  
  def all_feature_files
    all_entries_in_feature_files_path = Dir.new(feature_files_path).entries
    feature_entries =  all_entries_in_feature_files_path.select do |file|
      !!(file =~ /\.#{feature_file_suffix}$/)
    end
    feature_entries.map do |file|
      feature_files_path + "/" + file
    end
  end
  
  def all_feature_files_as_strings
    feature_files.map do |file|
      feature_string = ""
      File.open(file) do |f|
        f.readlines.each do |l|
          feature_string << l
        end
      end
      feature_string
    end
  end
end