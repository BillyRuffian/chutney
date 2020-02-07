module Chutney
  # service class to lint for tags used multiple times
  class TagUsedMultipleTimes < Linter
    def lint
      scenarios do |feature, scenario|
        total_tags = tags_for(feature) + tags_for(scenario)
        double_used_tags = total_tags.find_all { |a| total_tags.count(a) > 1 }.uniq!
        next if double_used_tags.nil?
                
        add_issue(
          I18n.t('linters.tag_used_multiple_times', tags: double_used_tags.join(',')), feature
        )
      end
    end
  end
end
