# frozen_string_literal: true

SITE_NAME = ENV['SITE_NAME']
SITE_VIEW_ID = ENV['SITE_VIEW_ID']

class Admin::HomeController < Admin::Base
  def index
    analytics = Analytics::ReportService.new(SITE_NAME, SITE_VIEW_ID)
    @analytics_daily_reports = analytics.report_users_count_by_date('today', 'today')

    start_date = Time.zone.today.beginning_of_month.strftime('%Y-%m-%d')
    @analytics_monthly_reports = analytics.report_users_count_by_date(start_date, 'today')
  end

  def fetch; end
end
