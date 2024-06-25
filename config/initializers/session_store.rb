# Rails.application.config.session_store :cookie_store, key: '_your_app_session', secret: '1dd2c8182842c2ae3f02892f128dec9b68ae0e6bb59e11a63131be632ea38fbf0979c235a723b8556ce76a020ca655c3711bcb42bb42668407c6a69badadcbb0'
Rails.application.config.session_store :cookie_store, key: '_your_app_session', domain: :all, tld_length: 2, secure: Rails.env.production? ? true : false
