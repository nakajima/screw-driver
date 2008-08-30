helpers do
  def report(str, params=nil)
    params ? SUITE.failed!(params) : SUITE.passed!
    $stdout.print(str)
    $stdout.flush
    :ok
  end
end