module ApplicationHelper

	def number_alerts
		Task.joins(:material).where('tasks.updated_at < ? and materials.in_deposito = ?', 
			Time.now.at_beginning_of_day - 3.days, false).count
	end
end
