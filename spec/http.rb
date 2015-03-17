require_relative "../helper/spec_helper.rb"

describe "SLES 12 HTTP server (apache2)" do

  before(:all) do
    # Start the previously create vagrant VM - opensuse_vm. 
    $vm = start_system(box: "autoyast_vm")
  end

  it "checks, if http runs" do
    run_test_script("http.sh")
  end

  after(:all) do
    # Shutdown the vagrant box.
    $vm.stop
  end
end
