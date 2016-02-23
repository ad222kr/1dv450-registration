class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  # Checks wheter the default version is required or the Accept header matches
  def matches?(req)
    @default || req.headers['Accept'].inluce?("application/vnd.registration-1dv450.v#{@version}")
  end

end