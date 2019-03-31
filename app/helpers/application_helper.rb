module ApplicationHelper
  def admin_user
    admin_user = false
    admin_user = true if current_member && current_member.id == 1
    admin_user
  end

  def default_meta_tags
    {
      site: 'andmorefine',
      title: 'andmorefine',
      reverse: true,
      charset: 'utf-8',
      description: 'andmorefineでは、気持ち悪いことわざイラストを提供しています。',
      keywords: 'andmorefine,気持ち悪い,イラスト,ことわざ',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: 'https://d2y9vn9mruehfd.cloudfront.net/img/favicons/favicon.ico' },
        { href: 'https://d2y9vn9mruehfd.cloudfront.net/img/favicons/apple-touch-icon-180x180.png', rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' }
      ],
      og: {
        site_name: 'andmorefine.com', # もしくは site_name: :site
        title: 'andmorefine', # もしくは title: :title
        description: 'andmorefineでは、気持ち悪いことわざイラストを提供しています。', # もしくは description: :description
        type: 'website',
        url: request.original_url,
        image: 'https://d2y9vn9mruehfd.cloudfront.net/img/proverb/AE21B67F-63A7-44B4-9CD6-7953ED3EF325.jpeg',
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary',
        site: '@andmorefine'
      }
    }
  end
end
