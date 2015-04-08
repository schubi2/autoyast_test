AutoYaST Integration Tests
===========================

Test framework for running AutoYaST integration tests by using veewee,
 vagrant and pennyworth.

Features
--------

  * Building KVM images by using AutoYaST profiles.
  * Checking these KVM images with rspec tests.
  * Generating own installation ISOs with local built RPMs or the newest one from OBS.


Installation
------------

  1. Install packages 'mkdud' and 'mksusecd' from OBS

  2. configure `sudo` in order to run the `mksusecd`, `systemctl start libvirtd` and `zypper in` command as root

  3. generate a ssh-key (e.g. with ssh-keygen) if you do not have one

  4. install and start `virt-manager`

  5. [configure default network](https://tails.boum.org/doc/advanced_topics/virtualization/virt-manager/index.de.html#index3h1) in `virt-manager`

  6. install [pennyworth](https://github.com/SUSE/pennyworth#installation)

  7. clone autoyast_test repository and install needed GEMs

        $ git clone https://github.com/schubi2/autoyast_test
        $ cd autoyast_test
        $ bundle install



Running
-------

For a complete list of tasks, run:

    $ rake -T

To run the testsuite, use the `test` Rake task:

    $ rake test

This runs all tests defined in spec/*.rb (e.g. spec/tftp.rb):
* Building a KVM image by using the AutoYaST configuration file (e.g. tftp.xml)
      You can watch the installation by using `virt-manager`. The image is `autoyast`.
* Starting the built image.
  You can watch it by using `virt-manager`. The image is `vagrant_autoyast_vm`.
* Running rspec tests on this machine which are defined in e.g. spec/tftp.rb.

To run only one single test use:

    $ rake test[<absolute_path_to_test_file>]

e.g. `rake test[/src/autoyast_test/spec/sles12.rb]`

To generate a new installation image based on SLES12 call:

    $ rake build_iso[sles12]

The process is defined in build_iso/sles12.rb:

* Fetching all RPMs (defined in build_iso/sles12.obs_packages) from OBS
* Fetching all local RPMs (defined in build_iso/sles12.local_packages)
* Fetching official SLES12 ISO
* Generating a new SLES12 ISO with this new RPM packages
* Copying new SLES12 ISO into test environment (directory kiwi/iso)

This new ISO image will be used for running tests in the future.

To use the official SLES12 ISO (default setting) for tests just call:

    $ rake build_iso[default]

