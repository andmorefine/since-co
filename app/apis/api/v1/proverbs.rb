module API
  module V1
    class Proverbs < Grape::API
      before do
        header 'Access-Control-Allow-Origin', '*'
      end
      resource :proverbs do
        desc 'GET /api/v1/proverbs/'
        get '/' do
          # Proverb.all
        end
      end
    end
  end
end
