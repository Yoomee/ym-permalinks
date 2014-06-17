Given(/^there is a page with a permalink$/) do
  @test_path = 'test-path'
  @page = create(:page, permalink_path: @test_path)
end

When(/^I go to the permalink$/) do
  visit @test_path
end

Then(/^I should see the page$/) do
  expect(page).to have_content(@page.title)
end

Given(/^there is not page with a permalink$/) do
  @test_path = 'test-path'
end

Then(/^going to the non\-existant page should raise a page not found error$/) do
  expect {
    visit @test_path
   }.to raise_error(ActionController::RoutingError)
end
