#!/usr/bin/env ruby
require File.expand_path("../../config/environment", __FILE__)
STDOUT.sync = true

Stalker::job 'user.fetch_details' do |args|
  begin
  	rec = SmsMod::Receiver.new
  	rec.get_messages
  rescue
    Rails.logger.warn "Suspect too fast, requeuing"
  end
end
jobs = ARGV.shift.split(',') rescue nil
Stalker.work jobs