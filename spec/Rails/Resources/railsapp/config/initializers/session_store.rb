# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_railsapp_session',
  :secret      => '9480cb0a826b3c0616592fce478433a8a330bf8d3a613c7b259a2da39c45f7bf51fe5aba27a5c18220d0b6b5968416daa04fda6160809d9cba2fce64193d9770'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
