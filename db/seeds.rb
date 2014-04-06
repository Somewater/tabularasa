require 'active_record/fixtures'
require "i18n_columns"

raise "Sections altready exists" unless Section.count == 0

ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/db/fixtures", ['sections', 'text_pages'])
