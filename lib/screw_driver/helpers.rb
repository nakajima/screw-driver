helpers do
  def padded(spaces=1)
    spaces.times { puts "" }
    yield
    spaces.times { puts "" }
    :ok
  end
  
  def report(str, params=nil)
    params ? SUITE.failed!(params) : SUITE.passed!
    $stdout.print(str)
    $stdout.flush
    :ok
  end
end