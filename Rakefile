require 'rake'

desc "Setup local development environment"
task :install do
  # update_homebrew
  configure_nginx
  install_dnsmasq
end

def update_homebrew
  puts
  puts "======================================================"
  puts "Updating Homebrew."
  puts "======================================================"
  `brew update`
  puts
  puts
end

private
def shout(message)
  puts "======================================================"
  puts "\e[32m #{message}\e[0m"
  puts "======================================================"
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
  shout("Replacing stock nginx config with our own")

  `curl -fsSL -o /usr/local/etc/nginx/nginx.conf https://raw.githubusercontent.com/ernie/the_setup/master/01_nginx/nginx.conf`

  `ruby -pi.bak -e "gsub(/<MY_PROJECT_ROOT>/, '$HOME/Projects')" /usr/local/etc/nginx/nginx.conf`

  `curl -fsSL -o /usr/local/etc/nginx/proxy_ports.conf https://raw.githubusercontent.com/ernie/the_setup/master/01_nginx/proxy_ports.conf`
end

def install_dnsmasq
  if(system('brew install --quiet dnsmasq'))
    update_dnsmasq_config
  else
    shout("Error installing dnsmasq.")
    Process.exit(0)
  end
end

def update_dnsmasq_config
  shout("Will do it later")
end
