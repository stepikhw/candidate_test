# frozen_string_literal: true

class ScenarioData
  attr_accessor :users_full_info, :users_id

  def initialize
    @users_id = {}
  end
end

class WebPageScenarioData
  attr_accessor :link_to_the_latest_release, :directory_to_download_file, :finished_downloads

  def initialize
    # В идеале это должно было бы читаться из конфига
    @directory_to_download_file = Dir.pwd + '/features/tmp/'
  end
end
