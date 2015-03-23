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
  shout("Updating nginx config.")

  `curl -fsSL -o /usr/local/etc/nginx/nginx.conf https://raw.githubusercontent.com/ernie/the_setup/master/01_nginx/nginx.conf`

  `ruby -pi.bak -e "gsub(/<MY_PROJECT_ROOT>/, '$HOME/Projects')" /usr/local/etc/nginx/nginx.conf`

  `curl -fsSL -o /usr/local/etc/nginx/proxy_ports.conf https://raw.githubusercontent.com/ernie/the_setup/master/01_nginx/proxy_ports.conf`

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

  `curl -fsSL -o /usr/local/etc/dnsmasq.conf https://raw.githubusercontent.com/ernie/the_setup/master/02_dnsmasq/dnsmasq.conf`

  `sudo cp -fv /usr/local/opt/dnsmasq/*.plist /Library/LaunchDaemons`

  `sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist`

end

def configure_pfctl
  shout("Updating pfctl")

  `sudo curl -fsSL -o /etc/pf.conf \
  https://raw.githubusercontent.com/ernie/the_setup/master/03_pfctl/pf.conf`

  `sudo curl -fsSL -o /etc/pf.anchors/devel.local \
  https://raw.githubusercontent.com/ernie/the_setup/master/03_pfctl/pf.anchors/devel.local`

  `sudo curl -fsSL -o /etc/pf.anchors/devel.local \
  https://raw.githubusercontent.com/ernie/the_setup/master/03_pfctl/pf.anchors/devel.local.forwarding`

  `sudo curl -fsSL -o /Library/LaunchDaemons/devel.local.pfctl.plist \
  https://raw.githubusercontent.com/ernie/the_setup/master/03_pfctl/devel.local.pfctl.plist`

  `sudo chown root:wheel /Library/LaunchDaemons/devel.local.pfctl.plist`

  `sudo launchctl load /Library/LaunchDaemons/devel.local.pfctl.plist`

  `sudo /sbin/pfctl -e -f /etc/pf.conf`
end
