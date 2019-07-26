# frozen_string_literal: true

SITE_NAME = ENV['SITE_NAME']
SITE_VIEW_ID = ENV['SITE_VIEW_ID']

class Admin::HomeController < Admin::Base
  def index
    analytics = Analytics::ReportService.new(SITE_NAME, SITE_VIEW_ID)
    @analytics_reports = analytics.report_users_count_by_date("today", "today")
  end

  def fetch
  end
end
