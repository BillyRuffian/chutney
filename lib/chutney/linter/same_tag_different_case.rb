# frozen_string_literal: true

require 'chutney/linter'

module Chutney
  # service class to lint for missing verifications
  class SameTagDifferentCase < Linter
    def all_known_tags
      # rubocop:disable Style/ClassVars
      @@all_known_tags ||= []
      # rubocop:enable Style/ClassVars
    end

    def lint
      scenarios do |feature, scenario|
        total_tags = tags_for(feature) + tags_for(scenario)

        total_tags.each do |tag|
          collision_with = case_collision(tag)
          if collision_with
            add_issue(I18n.t('linters.same_tag_different_case',
                             existing_tag: collision_with, tag: tag),
                      feature, scenario)
          else
            @@all_known_tags << tag
          end
        end
      end
    end

    def case_collision(tag)
      return nil if all_known_tags.include?(tag)

      all_known_tags.select { |t| t.casecmp(tag).zero? }.first
    end
  end
end
