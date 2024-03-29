require "application_system_test_case"

class UnicornsTest < ApplicationSystemTestCase

  test "unicorn count" do

    visit root_url

    assert_selector ".unicorn-card", count: Unicorn.count

  end

  test "visiting the index" do

    visit root_url

    assert_selector "h2", text: "unicorn"

  end

  test "visite show" do

    visit root_url

    click_on Unicorn.first.name
    assert_selector "h1", text: Unicorn.first.name
  end


  test "as user add a unicorn to rent" do
    login_as users(:bob)
    visit "/unicorns/new"
    # save_screenshot

    fill_in "Name", with: "Miniteste"
    fill_in "Description", with: "LOREM LOREM"
    fill_in "Address", with: "75 rue de Buzenval, Paris"
    fill_in "Price", with: "999"
    fill_in "Image url", with: "https://media.istockphoto.com/id/937170838/fr/vectoriel/mire-de-t%C3%A9l%C3%A9vision-des-rayures.jpg?s=612x612&w=0&k=20&c=_IGxU2svrhWY_nODoX2lyGKZcepVCVpkzlqRySO-WrI="
    # save_screenshot

    click_on "Create Unicorn"
    # save_screenshot

    sleep 2

    assert_text "Miniteste"
  end

end
