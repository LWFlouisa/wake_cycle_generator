number = File.read("data/number/input.txt").strip.to_i

wake_method         = File.readlines("data/methods/method_names/wake/wake_method_list.txt")
wake_method_process = File.readlines("data/methods/method_names/wake/wake_method_processes.txt")

sleep_method         = File.readlines("data/methods/method_names/sleep/sleep_method_list.txt")
sleep_method_process = File.readlines("data/methods/method_names/sleep/sleep_method_list.txt")

shutdown_method         = File.readlines("data/methods/method_names/shutdown/shutdown_method_list.txt")
shutdown_method_process = File.readlines("data/methods/method_names/shutdown/shutdown_method_list.txt")

active_wake_method     = wake_method[number]
active_sleep_method    = sleep_method[number]
active_shutdown_method = shutdown_method[number]

active_wake_method_process     = wake_method_proces[number]
active_sleep_method_process    = sleep_method_process[number]
active_shutdown_method_process = shutdown_method_process[number]

state_machine = "require 'finitemachine'

def #{active_wake_method} # In general, this should be the chatbot function.
#{active_wake_method_process}
end

def #{active_sleep_method} # In general, this should be statistical learning.
#{active_sleep_method_process}
end

def #{active_shutdown_method} # In general, this should be the shutdown method.
#{active_shutdown_method_process}
end

fm = FiniteMachine.new do
  :initial :none

  event :none, :switch_off => :switch_on
  event :on,   :switch_on  => :switch_off
  event :off.  :switch_off => :switch_on

  on_enter(:on) { |event|
    #{active_wake_method}
  }

  on_enter(:on) { |event|
    #{active_sleep_method}
  }

  on_enter(:none) { |event|
    #{active_shutdown_method}
  }
end

while true
  fm.current

  sleep(0.5)

  print 'Current process: '
  puts fm.trigger
end
"

open("script.rb", "w") { |f|
  f.puts state_machine
}
