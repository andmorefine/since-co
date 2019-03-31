require 'octokit'

class Github::IssueService
  def initialize(params = {})
    @title = params[:title].present? ? params[:title] : 'title'
    @body = params[:body].present? ? params[:body] : 'body'
  end

  def create
    client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])

    repo = 'andmorefine/since-co'
    title = @title
    body = @body
    options = { labels: 'contact' }

    res = client.create_issue(repo, title, body, options)
  end
end
