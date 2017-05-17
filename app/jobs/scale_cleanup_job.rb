class ScaleCleanupJob < ApplicationJob
  queue_as :default

  def perform
    Scale.all.each do |scale|
      if scale.user_id == nil && scale.notes.count > 1 && DateTime.now.to_i - scale.updated_at.to_i > 3600
        scale.destroy
      end
    end
  end
end
