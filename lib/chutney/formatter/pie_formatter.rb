# frozen_string_literal: true

require 'pastel'
require 'tty/pie'

module Chutney
  # format results as pie charts
  class PieFormatter < Formatter
    def initialize
      super
    end
    
    def format
      data = top_offences.map do |offence|
        {
          name: offence.first,
          value: offence.last,
          color: colour_loop,
          fill: char_loop
        }
      end
      print_report(data)
    end
    
    def print_report(data)
      return if data.empty?

      print TTY::Pie.new(data: data, radius: 8, legend: { format: '%<label>s %<name>s %<value>i' })
      puts
    end
    
    def top_offences
      offence = Hash.new(0)
      files_with_issues.each do |_file, linter|
        linter.each do |lint|
          offence[lint[:linter]] += lint[:issues].count
        end
      end
      offence.reject { |_k, v| v.zero? }.sort_by { |_linter, count| -count }
    end
    
    def char_loop
      @char_looper ||= Fiber.new do 
        chars = %w[• x + @ * / -]
        current = 0
        loop do
          current = 0 if current >= chars.count
          Fiber.yield chars[current]
          current += 1
        end
      end
      @char_looper.resume
    end
    
    def colour_loop
      @colour_looper ||= Fiber.new do 
        colours = %i[bright_cyan bright_magenta bright_yellow bright_green] 
        current = 0
        loop do
          current = 0 if current >= colours.count
          Fiber.yield colours[current]
          current += 1
        end
      end
      @colour_looper.resume
    end
    
    def put_summary
      pastel = Pastel.new
      print "#{files.count} features inspected, "
      if files_with_issues.count.zero?
        puts pastel.green('all taste delicious')
      else
        puts pastel.red("#{files_with_issues.count} taste nasty")
      end
    end
    
  end
end
