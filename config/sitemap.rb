# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://andmorefine.com"

SitemapGenerator::Sitemap.create do

  add new_contact_path, :changefreq => 'weekly'

  add proverb_index_path, :priority => 0.7, :changefreq => 'daily'

  Proverb.find_each do |proverb|
    add proverb_path(proverb), :lastmod => proverb.updated_at
  end
  MAlphabetal.find_each do |alphabetal|
    add alphabetal_path(alphabetal), :lastmod => alphabetal.updated_at
  end
end
