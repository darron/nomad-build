class Nomad < FPM::Cookery::Recipe
  name 'nomad'

  version '0.3.1'
  revision '1'
  description 'A Distributed, Highly Available, Datacenter-Aware Scheduler'

  homepage 'https://www.nomadproject.io/'
  source "https://releases.hashicorp.com/#{name}/#{version}/#{name}_#{version}_linux_amd64.zip"
  sha256 '467fcebe9f0a349063a4f16c97cb71d9c57451fc1f10cdb2292761cf56542671'

  maintainer 'Darron Froese <darron@froese.org>'
  vendor 'octohost'

  license 'Mozilla Public License, version 2.0'

  conflicts 'nomad'
  replaces 'nomad'

  build_depends 'unzip'

  pre_install 'preinst'
  post_install 'postinst'

  def build
    safesystem "mkdir -p #{builddir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/#{name}_#{version}_linux_amd64/#{name} #{builddir}/usr/local/bin/"
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/usr/local/bin/#{name} #{destdir}/usr/local/bin/#{name}"
    etc('init').install_p workdir('nomad.upstart'), 'nomad.conf'
    etc('nomad.d').install_p workdir('server.hcl'), 'server.hcl'
    etc('default').install_p workdir('nomad.default'), 'nomad'
    etc('logrotate.d').install_p workdir('nomad.logrotate'), 'nomad'
  end
end
