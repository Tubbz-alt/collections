require "integration_test_helper"
require_relative "../support/coronavirus_landing_page_steps"

class CoronavirusLandingPageTest < ActionDispatch::IntegrationTest
  include CoronavirusLandingPageSteps

  describe "the coronavirus landing page" do
    it "renders" do
      given_there_is_a_content_item
      when_i_visit_the_coronavirus_landing_page
      then_i_can_see_the_header_section
      then_i_can_see_the_nhs_banner
      then_i_can_see_the_accordions
    end

    it "has sections that can be clicked" do
      given_there_is_a_content_item
      when_i_visit_the_coronavirus_landing_page
      and_i_click_on_an_accordion
      then_i_can_see_the_accordions_content
    end

    it "renders machine readable content" do
      given_there_is_a_content_item
      when_i_visit_the_coronavirus_landing_page
      then_the_special_announcement_schema_is_rendered
    end
  end
end
