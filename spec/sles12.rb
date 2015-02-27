require_relative "../helper/spec_helper.rb"

describe "SLES 12 installation" do

  before(:all) do
    # Start the previously create vagrant VM - opensuse_vm. 
    $vm = start_system(box: "autoyast_vm")
  end

  it "checks, if user -vagrant- has been created" do
    shell = __FILE__.gsub(".rb",".sh")
    if File.exists?(shell)
      # Copy the file to be tested to /tmp inside the booted box and execute it.
      $vm.inject_file(shell, "/tmp")
      actual = $vm.run_command("source /tmp/#{File.basename(shell)}", stdout: :capture, as: "vagrant")

      # Compare the expected value.
      expected = "AUTOYAST OK"
      expect(actual.split("\n").last).to eq(expected)
    end
  end

  after(:all) do
    # Shutdown the vagrant box.
    $vm.stop
  end
end
