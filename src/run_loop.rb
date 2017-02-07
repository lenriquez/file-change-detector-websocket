require 'singleton'

class RunLoop
  include Singleton

  def initializer
    @queue   = []
    @clients = []
  end

  def add_job( name, job )

  end

  def remove_job( name )

  end

  def loop
    loop do

    end
  end

end
