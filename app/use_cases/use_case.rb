class UseCase

  include Virtus.model

  def self.run(*args)
    new(*args).run
  end
end