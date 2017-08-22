require 'spec_helper'

feature 'Simple Checkout Payment with Forte', js: true do
  before do
    page.driver.headers = {
      'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X)'
    }

    visit        root_path
    click_button 'Pay Now'
  end

  scenario 'read the payment form information' do
    expect(page).to have_content('Forte Payment System')
    page.within_frame('imodal0') do
      expect(page).to have_content('Payment Method')
      expect(page).to have_content('Billing information')
    end
  end

  #scenario 'closing popup' do
  #  pending 'Unable to click close button!'

  #  page.within_frame('imodal0') do
  #    #page.find('button.forteclose').click
  #    click_on 'x'
  #  end
  #
  #  expect(page).not_to have_content('Forte Payment System')
  #  expect(page).to     have_content('begin')
  #  expect(page).to     have_content('abort')
  #end

  #scenario 'pay with Credit Card' do
  #  pending 'Unable to click next button!'
  #  page.within_frame('imodal0') do
  #    page.find('img[alt="Credit Card"]').click

  #    fill_in 'card_number',  with: 4444333322221111
  #    fill_in 'expire',       with: Time.now.end_of_year.strftime('%m %Y')
  #    fill_in 'cvv',          with: 123

  #    fill_in 'billing_name',          with: 'Steve Job'
  #    #fill_in 'billing_street_line1',  with: '1 Infinite Loop', first: true
  #    #fill_in 'billing_street_line2',  with: ''
  #    fill_in 'billing_locality',      with: 'Cupertino'
  #    select  'California',            from: 'billing_region'
  #    fill_in 'billing_postal_code',   with: '95014'
  #    fill_in 'billing_phone_number',  with: '00-692-7753'
  #    fill_in 'billing_email_address', with: 'steve@apple.com'

  #    within('.bottom-nav') do
  #      click_on 'Next', disabled: false
  #    end

  #    expect(page).to have_content('Amount Summary')

  #    click_on 'Authorize'
  #  end
  #  take_screenshot 'pay with Credit Card'

  #  expect(page).to have_content('begin')
  #  expect(page).to have_content('success')
  #end

  #scenario 'pay with eCheck' do
  #  pending 'Unable to click eCheck tab!'

  #  page.within_frame('imodal0') do
  #    page.find('img[alt="eCheck"]').click
  #  end

  #  expect(page).to have_content('begin')
  #  expect(page).to have_content('success')
  #end
end
