require 'singleton'

# This class is responsable to execute the loop that will delegate to other
# classes the new connections checking, file change detection
# and message sending
class RunLoop
  include Singleton

  def initializer
    @queue   = []
    @clients = []
  end

  def add_job(name, job) end

  def remove_job(name) end

  def loop
    loop do
    end
  end
end
