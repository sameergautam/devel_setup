require 'rake'

desc "Setup local development environment"
task :install do
  can_i_run_sudo = `sudo uptime 2>&1|grep "load"|wc -l`
  if(can_i_run_sudo.to_i > 0)
    # update_homebrew
    configure_nginx
    configure_dnsmasq
    configure_pfctl
  else
    shout("Seems like you are not in sudoers file.")
  end
end

private
def shout(message)
  puts "======================================================"
  puts "\e[32m #{message}\e[0m"
  puts "======================================================"
end

def update_homebrew
  shout("Updating brew.")
  if system('brew update')
    puts "Brew updated"
  else
    puts "Something wrong with brew update"
    Process.exit(0)
  end
end

def configure_nginx
  if(system('brew install nginx'))
    update_nginx_config
  else
    shout("Error installing nginx.")
    Process.exit(0)
  end
end

def update_nginx_config
  shout("Updating stock nginx config with our own.")

  `sed -e "s;<MY_PROJECT_ROOT>;$HOME/Projects;g" config_files/nginx.conf > /usr/local/etc/nginx/nginx.conf`

  `cp -r ssl config_files/proxy_ports.conf /usr/local/etc/nginx/`

  system('sudo mkdir /etc/resolver')

  `echo nameserver 127.0.0.1 | sudo tee /etc/resolver/devel`
end

def configure_dnsmasq
  if(system('brew install --quiet dnsmasq'))
    update_dnsmasq_config
  else
    shout("Error installing dnsmasq.")
    Process.exit(0)
  end
end

def update_dnsmasq_config
  shout("Updating dnsmasq config.")

  `cp config_files/dnsmasq.conf /usr/local/etc/dnsmasq.conf`

  `sudo cp -fv /usr/local/opt/dnsmasq/*.plist /Library/LaunchDaemons`

  `sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist`

end

def configure_pfctl
  shout("Updating pfctl")

  `sudo cp config_files/pf.conf /etc/pf.conf`

  `sudo cp config_files/devel.local /etc/pf.anchors/devel.local`

  `sudo cp config_files/devel.local.forwarding /etc/pf.anchors/devel.local.forwarding`

  `sudo cp config_files/devel.local.pfctl.plist /Library/LaunchDaemons/devel.local.pfctl.plist`

  `sudo chown root:wheel /Library/LaunchDaemons/devel.local.pfctl.plist`

  `sudo launchctl load /Library/LaunchDaemons/devel.local.pfctl.plist`

  `sudo /sbin/pfctl -e -f /etc/pf.conf`
end
