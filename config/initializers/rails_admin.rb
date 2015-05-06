RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Authenticate using Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Authorize manually ==
  config.authorize_with do
    redirect_to main_app.root_path unless current_user.try(:admin?)
  end

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard # mandatory
    index # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.included_models = %w(User Game)

  config.model "User" do
    object_label_method :username
    edit { exclude_fields :slug }
  end

  config.model "Game" do
    edit { exclude_fields :slug }
  end
end
