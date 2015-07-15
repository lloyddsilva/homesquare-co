module EventsHelper
	def attending_text
		if @event.attending_users.include?(current_user)
			"You are attending"
		else
			"Attend"
		end
	end

	def maybe_text
		if @event.maybe_users.include?(current_user)
			"You might be attending"
		else
			"Maybe"
		end
	end

	def decline_text
		if @event.declined_users.include?(current_user)
			"You are not attending"
		else
			"Decline"
		end
	end
end
