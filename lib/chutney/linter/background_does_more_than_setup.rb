module Chutney
  # service class to lint for background that does more than setup
  class BackgroundDoesMoreThanSetup < Linter   
    def lint
      background do |feature, background|
        next unless background.key? :steps
        
        invalid_steps = background[:steps].select do |step| 
          when_word?(step[:keyword]) || then_word?(step[:keyword])
        end
        next if invalid_steps.empty?

        add_issue(I18n.t('linters.background_does_more_than_setup'), feature, background)
      end
    end
  end
end
