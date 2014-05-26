require 'spec_helper'

describe 'neo4j', :type => :class do

  context "if running on CentOs" do
    let (:facts) { {
      :osfamily => 'Redhat',
      :operatingsystemrelease => '6.5'
    } }

    it { should compile.with_all_deps }
    it { should contain_class('neo4j::install').that_comes_before('neo4j::config') }
    it { should contain_class('neo4j::service').that_subscribes_to('neo4j::config') }
    it { should contain_class('neo4j::config') }
    it { should contain_service('neo4j') }

    context "install from file" do
      let (:params) { {'installation_source' => 'file'} }

      it { should contain_file('/tmp/neo4j.rpm') }
      it { should contain_package('neo4j').with(
        'provider' => 'rpm',
        'ensure'   => 'present',
        'source'   => '/tmp/neo4j.rpm'
      ) }
      it { should_not contain_yumrepo('neo4j') }

    end

    context "install from repo" do
      let (:params) { {'installation_source' => 'repo'} }

      it { should_not contain_file('/tmp/neo4j.rpm') }
      it { should contain_package('neo4j').with_ensure('present') }
      it { should contain_yumrepo('neo4j') }

    end

  end

end
