extends Node

# Debug variable, used to display internal messages or not
var debug : bool = false

# Error handling variable, used to display internal error only
var error_handling : bool = false

# List of messages. Each message contains a list of listeners.
var messages = {}


# `send` broadcasts the message to the listeners and supplies the parameters and the broadcaster, if supplied
func send(message : String, params : Dictionary = {}) -> bool:
	# Check if the message exists
	if messages.has(message):
		# If it exists, broadcast to every listener
		if messages[message].size() > 0:
			for listener in messages[message]:
				# Check if the listener has been freed before continuing.
				if is_instance_valid(listener):
					# Broadcast to each action
					for action in messages[message][listener]:
						if listener.has_method(action):
							#If the action exists, broadcast the message
							if params.size() == 0:
								listener.call(action)
							else:
								listener.call(action, params)
							
							# Remove if it is suppose to fire only once
							if messages[message][listener][action]:
								messages[message][listener].erase(action)
								if debug: print("action ", action, " fired once for listener ", listener.name, " on message ", message, " and was removed.")
						else:
							# Check if the listener was deleted. If so remove it from the list
							if debug: print("Not such action (", action, ") for listener ", listener.name)
			
					# If the listener doesn't have any actions left, remove it from the message
					if messages[message][listener].size() == 0:
						messages[message].erase(listener)
						
				else:
					# The listener was freed from the scene. Delete it from the message.
					messages[message].erase(listener)
		
			if debug: print("Successfully sent message: '", message, "' using params: ", params)
			return true
		else:
			if debug || error_handling: print("No listeners for message ", message)
			return false
	else:
		if debug || error_handling: print("Send failed. Message ", message, " doesn't exist")
		return false

# `is_listening` verify if the listener is listening to the supplied message. Optionally it can verify if it is listening using a specific action
func is_listening(message : String, listener : Object, action = "") -> bool:
	if listener == null:
		if debug || error_handling: print("Listener is invalid. Cannot verify if it is listening.")
		return false
	
	if action == "":
		# Check if the listerner is listening to the supplied message.
		if messages.has(message) && messages[message].has(listener):
			return true
	else:
		# Check if the listerner is listening to the supplied message using the supplied action
		if messages.has(message) && messages[message].has(listener) && messages[message][listener].has(action):
			return true
	
	# If the function hasn't returned yet, it means the listener isn't listening
	return false

# `listen` adds the listener to the list of listeners for the message that will call the action
func listen(message : String, listener : Object, action : String, once = false) -> bool:
	# Check to make sure the listener is valid
	if listener == null:
		if debug || error_handling: print("Listener is invalid. Cannot add to message ", message, " using action " , action)
		return false
	
	# Check if the message already exists in the list of listeners, if not add it.
	if !messages.has(message):
		messages[message] = {}
	
	# Check if the listener already exists, if not add it.
	if !messages[message].has(listener):
		messages[message][listener] = {}
	
	# Add the action to the listener for the supplied message, if necessary
	if !messages[message][listener].has(action):
		messages[message][listener][action] = once
	else:
		if debug: print("Listener ", listener.name, " already listening for message ", message, " with action ", action)
		return false

	# Success
	if debug: print("Listener ", listener.name, " now listening for message ", message, " with action ", action, ". Fire once: ", once)
	return true

	
# `ignore` removes the action listed from the listener of the specified message
func ignore(message : String, listener : Object, action : String) -> bool:
	if listener == null:
		if debug || error_handling: print("Listener is invalid. Cannot ignore message ", message)
		return false
	
	# Check for the message
	if messages.has(message):
		# Check for the listener
		if messages[message].has(listener):
			# Remove the action if it exists
			if messages[message][listener].has(action):
				if debug: print("Successfully removed action ", action, " for listener ", listener.name, " for message ", message)
				return true
			else:
				if debug || error_handling: print("Cannot remove action ", action, ". No such action for listener ", listener.name, " for message ", message)
				return false
		else:
			if debug || error_handling: print("Ignore failed. Listener ", listener.name, " not listening to message ", message)
			return false
	else:
		if debug || error_handling: print("Ignore failed for listener ", listener.name, ". Message ", message, " doesn't exist")
		return false
