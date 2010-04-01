# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bhamruby_session',
  :secret      => '3f792bdd9d940b7c4264e47c7ed5cc15005866b9ff89d9749ccc994708e869fd233ebf787922abe52e57ffb4855018e56bccb535eac8b3c719f2e8893bdb3e0f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
