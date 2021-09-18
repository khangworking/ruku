module RoomsHelper
  def duration_display(record)
    duration = ActiveSupport::Duration.build(record.duration).parts
    format("%02d:%02d:%02d", duration[:hours] || 0, duration[:minutes] || 0, duration[:seconds] || 0)
  end
end
