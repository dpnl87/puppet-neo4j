require 'spec_helper'

describe 'neo4j' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "neo4j class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('neo4j::params') }
        it { should contain_class('neo4j::install').that_comes_before('neo4j::config') }
        it { should contain_class('neo4j::config') }
        it { should contain_class('neo4j::service').that_subscribes_to('neo4j::config') }

        it { should contain_service('neo4j') }
        it { should contain_package('neo4j').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'neo4j class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('neo4j') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
