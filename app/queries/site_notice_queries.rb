module SiteNoticeQueries

  class << self

    def contact
      @contact ||= YAML.load_file(Ggp2.config.site_notice_file)['contact']
    end
  end
end
