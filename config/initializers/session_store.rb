# Rails.application.config.session_store :cookie_store, key: '_your_app_session', domain: :all, tld_length: 2, secure: true, same_site: :none
# Rails.application.config.session_store :cookie_store, key: '_your_app_session', secure: Rails.env.production?, same_site: :none
Rails.application.config.session_store :cookie_store, key: '_your_app_session', domain: :all, secure: Rails.env.production?, tld_length: 2

