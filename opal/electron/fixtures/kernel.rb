class Kernel
  def dirname
    `__dirname`
  end
  def process
    Electron::Process.new `process`
  end
end
