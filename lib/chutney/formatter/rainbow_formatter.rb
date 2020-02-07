require 'pastel'

module Chutney
  # pretty formatter
  class RainbowFormatter < Formatter
  
    def initialize
      super
      
      @pastel = Pastel.new
    end
  
    def format      
      files_with_issues.each do |file, linter|
        put_file(file)
        linter.filter { |l| !l[:issues].empty? }.each do |linter_with_issues|
          
          put_linter(linter_with_issues)
          linter_with_issues[:issues].each { |i| put_issue(i) }
        end
      end
      put_summary
    end
    
    def put_file(file)
      puts @pastel.cyan(file.to_s)
    end
    
    def put_linter(linter)
      puts @pastel.red("  #{linter[:linter]}")
    end
    
    def put_issue(issue)    
      puts "    #{@pastel.dim(issue.dig(:location, :line))} #{issue[:message]}"
    end
    
    def put_summary
      print "#{files.count} features inspected, "
      if files_with_issues.count.zero?
        puts @pastel.green('all taste delicious')
      else
        puts @pastel.red("#{files_with_issues.count} taste nasty")
      end
    end
    
  end
end
