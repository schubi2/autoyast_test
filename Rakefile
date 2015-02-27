# Copyright (c) 2015 SUSE LLC
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of version 3 of the GNU General Public License as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, contact SUSE LLC.
#
# To contact SUSE about this file by physical or electronic mail,
# you may find current contact information at www.suse.com

desc "Running autoyast integration tests"
task :test, [:name] do |name, args|
  base_dir = File.dirname(__FILE__)
  tests = [args[:name]] || Dir.glob(File.join( base_dir, "spec", "*.rb"))
  tests.each do |test_file|
    test_name = File.basename(test_file, ".rb")
    puts "---------------------------------------------------------------------------------"
    puts "********** Running test #{test_name} **********"
    puts "---------------------------------------------------------------------------------"
    puts "\n****** Creating KVM image ******\n"
    autoyast_file = File.join(base_dir, "kiwi/definitions/autoyast/autoinst.xml")
    FileUtils.cp( File.join(base_dir, "spec", test_name + ".xml"), autoyast_file)
    Dir.chdir(File.join( base_dir, "kiwi")) {
      puts "\n**** Building KVM image ****\n" 
      system "veewee kvm build autoyast --force"
      puts "\n**** Exporting KVM image into box file ****\n" 
      system "veewee kvm export autoyast --force"
    }
    FileUtils.rm(autoyast_file, :force => true)

    pennyworth_bin = File.join(base_dir,"/../pennyworth/bin/pennyworth")
    unless File.exist?(pennyworth_bin)
      puts "\n**************************************************************************"
      puts "Please install pennyworth from https://github.com/SUSE/pennyworth and adapt"
      puts "the path of /bin/pennyworth in Rakefile."
      puts "**************************************************************************"
      exit 1
    end
    puts "\n****** Importing vagrant box into pennyworth ******\n"
    system "#{pennyworth_bin} -d #{base_dir} import-base"

    if File.exist?(test_file)
      puts "\n****** Running test on created system ******\n"
      system "rspec #{test_file}"
    else
      puts "\n****** Running *NO* tests on created system ******\n"
    end
  end

end

