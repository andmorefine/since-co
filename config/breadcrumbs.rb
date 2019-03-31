crumb :root do
  link 'TOP', root_path
end

# proverb#index
crumb :proverbs do
  link "ことわざ", proverb_index_path
  parent :root
end

crumb :proverb do |project|
  link project.name, proverb_path(project)
  parent :proverbs
end

crumb :alphabetal do |project|
  link project.name, alphabetal_path(project)
  parent :proverbs
end

crumb :contact do
  link "お問い合わせ", new_contact_path
  parent :root
end

crumb :contact_thanks do
  link "完了", thanks_contact_index_path
  parent :contact
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
