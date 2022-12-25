require "application_system_test_case"

class QuotesTest < ApplicationSystemTestCase
  setup do
    @quote = quotes(:first)
  end

  test "Show a quote" do
    visit quotes_path
    click_link @quote.name

    assert_selector "h1", text: @quote.name
  end

  test "Creating a new quote" do
    visit quotes_path
    assert_selector "h1", text: "Quotes"

    click_on "New quote"
    assert_selector "h1", text: "New quote"

    fill_in "Name", with: "Capybara quote"
    click_on "Create quote"

    assert_selector "h1",  text: "Quotes"
    assert_text "Capybara quote"
  end

  test "Update a quote" do
    visit quotes_path
    assert_selector "h1", test: "Quotes"

    click_on "Edit", match: :first
    fill_in "Name", with: "Update quote"

    assert_selector "h1", text: "Quotes"
    click_on "Update quote"

    assert_selector "h1", text: "Quotes"
    assert_text "Update quote"
  end

  test "Destroying a quote" do
    visit quotes_path
    assert_text @quote.name

    click_on "Delete", match: :first
    assert_no_text @quote.name
  end
end
