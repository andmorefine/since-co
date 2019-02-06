# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://andmorefine.com"

SitemapGenerator::Sitemap.create do
  add proverb_index_path, :priority => 0.7, :changefreq => 'daily'

  Proverb.find_each do |proverb|
    add proverb_path(proverb), :lastmod => proverb.updated_at
  end
end
