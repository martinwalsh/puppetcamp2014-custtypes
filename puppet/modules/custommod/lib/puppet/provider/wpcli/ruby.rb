require 'mkmf'
Puppet::Type.type(:wpcli).provide :ruby do
  desc "..."

  # Required executables for the module
  commands :curl => 'curl'
  commands :php => 'php'

  @@wp_url = 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'

  def create
    # Using the puppet logger to output information - sends information to the puppet master
    debug("CREATE #{resource[:path]}")

    curl(['-o', "#{resource[:path]}/wp", @@wp_url])

    File.chmod(0755, "#{resource[:path]}/wp")

  end

  def destroy
    #No destroy
  end

  ## This provider will create a binary called 'wp'
  def exists?
    executable = find_executable 'wp'

    if executable.nil?
      return false
    else
      return true
    end
  end

end