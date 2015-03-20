require 'rake'

desc "Setup local development environment"
task :install do
  # update_homebrew
  # install_nginx
  update_nginx_config
  success_msg("installed")
end

def update_homebrew
  puts
  puts "======================================================"
  puts "Updating Homebrew."
  puts "======================================================"
  run %{ brew update }
  puts
  puts
end

private
def run(cmd)
  puts "[Running] #{cmd}"
  `#{cmd}`
end

def install_nginx
  puts "Installing nginx"
  puts
  run %{ brew install nginx }
end

def update_nginx_config
  puts
  puts "======================================================"
  puts "replacing stock nginx config with our own"
  puts "======================================================"
  puts
  puts "Enter the location for your project root: "
  project_root = STDIN.gets.chomp
  puts project_root
  run %{ curl -fsSL -o /usr/local/etc/nginx/nginx.conf https://raw.githubusercontent.com/ernie/the_setup/master/01_nginx/nginx.conf }
  run %{ ruby -pi.bak -e "gsub(/<MY_PROJECT_ROOT>/, '#{project_root}')" /usr/local/etc/nginx/nginx.conf }
  run %{ curl -fsSL -o /usr/local/etc/nginx/proxy_ports.conf https://raw.githubusercontent.com/ernie/the_setup/master/01_nginx/proxy_ports.conf }
end

def success_msg(action)
  puts
  puts
  puts
  puts "Development Environment has now been setup"
  puts
  puts
  puts
end
