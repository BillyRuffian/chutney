module Chutney
  # service class to lint for background that does more than setup
  class BackgroundDoesMoreThanSetup < Linter   
    def lint
      background do |feature, background|
      
        invalid_steps = background&.steps&.select do |step| 
          when_word?(step.keyword) || then_word?(step.keyword)
        end
        
        next if invalid_steps.nil? || invalid_steps.empty?
        add_issue(I18n.t('linters.background_does_more_than_setup'), feature, background, invalid_steps.first)
      end
    end
  end
end
