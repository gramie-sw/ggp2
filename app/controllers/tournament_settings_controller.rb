class TournamentSettingsController < ApplicationController

  def edit
    @tournament_settings_form = TournamentSettings::CreateForm.run
  end

  def update
    @tournament_settings_form =
        TournamentSettings::Update.run(tournament_settings_attributes: params[:tournament_settings])

    if @tournament_settings_form.errors.blank?
      redirect_to edit_tournament_settings_path, notice: t('model.messages.updated', model: t('general.settings'))
    else
      render :edit
    end
  end

end