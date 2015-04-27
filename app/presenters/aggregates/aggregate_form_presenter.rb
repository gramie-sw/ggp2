class AggregateFormPresenter

  attr_reader :aggregate

  def initialize aggregate
    @aggregate = aggregate
  end

  def model_translation(plural: false)
    count = plural ? 2 : 1
    if aggregate.phase?
      I18n.t('general.phase', count: count)
    else
      I18n.t('general.group', count: count)
    end
  end


end