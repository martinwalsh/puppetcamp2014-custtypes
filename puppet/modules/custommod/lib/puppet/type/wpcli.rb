# lib/puppet/type/wpcli.rb
Puppet::Type.newtype(:wpcli) do
  @doc = "Install The WP-CLI Tool"
  ensurable

  # A single parameter - the path to install the wp-cli binary.
  newparam(:path, :namevar => true) do
    desc "The wp-cli install location."
  end
end