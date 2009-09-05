require "/Users/mhennemeyer/Projekte/features/spec/Rails/Resources/de/features_helper.rb"

class AnmeldenTest < FeaturesTestCaseClass
  def test_NeuerBenutzerWirdAngemelded
  wenn_ich_die_Seite____oeffne("/"); dann_sehe_ich___("Anmelden"); wenn_ich_auf____klicke("Anmelden"); dann_sehe_ich___("Email:"); dann_sehe_ich___("	Und ")
end

end

