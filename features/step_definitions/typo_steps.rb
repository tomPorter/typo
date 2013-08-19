def log_into_admin_panel
  visit '/accounts/login'
  fill_in 'user_login', :with => 'admin'
  fill_in 'user_password', :with => 'aaaaaaaa'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

And /^I am logged out$/ do
  visit('/accounts/logout')
end

When /^I click on 'edit' for  "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

And /^the following articles exist:$/ do |articles_table|
  Article.destroy_all
  log_into_admin_panel
  articles_table.hashes.each do |article|
    visit path_to('the new article page')
    fill_in('article_title', :with => article['title'])
    fill_in('article__body_and_extended_editor', :with => article['body'])
    click_button("Publish")
    #save_and_open_page
  end
  visit('/accounts/logout')
end

Then /^I fill in 'Article ID' with the ID for "(.*?)"$/ do |article_title|
  article_to_be_merged = Article.find_by_title(article_title)
  target_id = article_to_be_merged.id
  fill_in 'merge_with', :with => target_id.to_s 
end