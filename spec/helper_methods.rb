# frozen_string_literal: true

# Helper methods...
def source_fixture(filename)
  File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', filename))
end
