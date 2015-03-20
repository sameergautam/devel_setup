require 'rake'

desc "Setup local development environment"
task :install do
  update_homebrew
  install_nginx
  success_msg("installed")
end

def update_homebrew
  puts
  puts "======================================================"
  puts "Updating Homebrew."
  puts "======================================================"
  run %{brew update}
  puts
  puts
end

def install_nginx
  puts "Installing nginx"
  puts
  run %{brew install nginx}
end

def success_msg(action)
  puts ""
  puts "       _                 _  __            _"
  puts "   ___| | ___  _   _  __| |/ _| __ _  ___| |_ ___  _ __ _   _"
  puts "  / __| |/ _ \| | | |/ _` | |_ / _` |/ __| __/ _ \| '__| | | |"
  puts " | (__| | (_) | |_| | (_| |  _| (_| | (__| || (_) | |  | |_| |"
  puts "  \___|_|\___/ \__,_|\__,_|_|  \__,_|\___|\__\___/|_|   \__, |"
  puts "                                                        |___/"
  puts ""
  puts "Development Environment has now been setup"
  puts ""
  puts ""
  puts ""
end
