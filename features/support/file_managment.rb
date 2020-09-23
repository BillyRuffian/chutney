# frozen_string_literal: true

def temporary_file(filename, content)
  feature_file = Tempfile.new(filename || '')
  feature_file.write(content)
  feature_file.rewind
  feature_file
end
