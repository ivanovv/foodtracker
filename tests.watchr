ENV["WATCHR"] = "1"
system 'clear'

def notify msg, title = "Watchr Test Results", urg = 'normal', img = nil
  msg += " in #{Dir.pwd.split(/\//).last(3).join("/")}"
  msg += " at #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"
  # TODO: parameterize default image
  img ||= urg == 'normal' ?
  '/usr/share/icons/Humanity/status/48/dialog-info.svg' : '/usr/share/icons/Humanity/status/48/dialog-error.svg'
  cmd = "notify-send -i #{img} -u #{urg} '#{title}' '#{msg}'"
  system cmd
  nil
end

def growl(message)
  growlnotify = `which growlnotify`.chomp
  title = "Watchr Test Results"
  image = message.include?('0 failures, 0 errors') ? "~/.watchr_images/passed.png" : "~/.watchr_images/failed.png"
  options = "-w -n Watchr --image '#{File.expand_path(image)}' -m '#{message}' '#{title}'"
  system %(#{growlnotify} #{options} &)
end

def run(cmd)
  puts(cmd)
  `#{cmd}`
end

def standard_test
  system('clear')
  result = yield
  if result
    lines = result.split("\n")
    line = lines.select {|line| line =~ /\d+ tests, \d+ assertions, \d+ failures, \d+ errors, \d+ skips/}.first
    if line
      errors = line.match(/(\d+) failures, (\d+) errors/)
      puts errors[1,2].join('')
      urg = errors[1,2].join('') == '00' ? 'normal' : 'critical'
      notify(line, 'Watchr Test Results', urg) rescue nil
    end
    puts result
  end
end

def run_test_file(file)
  standard_test {run(%Q(ruby -I"lib:test" -rubygems #{file}))}
end

def run_all_tests
  standard_test {run "rake test"}
end

def run_all_features
  system('clear')
  run "cucumber"
end

def related_test_files(path)
  Dir['test/**/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_test.rb/ }
end

def run_suite
  run_all_tests
  run_all_features
end

watch('test/test_helper\.rb') { run_all_tests }
watch('test/.*/.*_test\.rb') { |m| run_test_file(m[0]) }
watch('app/.*/.*\.rb') { |m| related_test_files(m[0]).map {|tf| run_test_file(tf) } }
watch('features/.*/.*\.feature') { run_all_features }

# Ctrl-\
Signal.trap 'QUIT' do
  puts " --- Running all tests ---\n\n"
  run_all_tests
end

@interrupted = false

# Ctrl-C
Signal.trap 'INT' do
  if @interrupted then
    @wants_to_quit = true
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
    # raise Interrupt, nil # let the run loop catch it
    run_suite
  end
end

