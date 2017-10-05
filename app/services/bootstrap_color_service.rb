class BootstrapColorService
  COLORS = %w[primary success info warning danger].freeze

  def initialize(opts = {})
    @taken = opts[:taken] || []
  end

  def random_available_color
    # assign a random color from the available colors
    (COLORS - @taken).sample
  end
end
