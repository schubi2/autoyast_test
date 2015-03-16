require_relative "../helper/spec_helper.rb"

describe "SLES 12 installation" do

  before(:all) do
    # Start the previously create vagrant VM - opensuse_vm. 
    $vm = start_system(box: "autoyast_vm")
  end

  it "checks, if user -vagrant- has been created" do
    run_test_script("user.sh")
  end

  it "checks, if files can be downloaded from tftp server" do
    run_test_script("tftp.sh")
  end

  it "; dns server and network is available" do
    run_test_script("dns.sh")
  end

  it "checks, if user scripts have been run" do
    run_test_script("autoinst-userscr.sh")
  end

  after(:all) do
    # Shutdown the vagrant box.
    $vm.stop
  end
end
