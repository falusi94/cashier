# frozen_string_literal: true

Dir[File.join(__dir__, 'integration/**/*_steps.rb')].each { |f| require f }
