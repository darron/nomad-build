class Nomad < FPM::Cookery::Recipe
  name 'nomad'

  version '0.4.0'
  revision '1'
  description 'A Distributed, Highly Available, Datacenter-Aware Scheduler'

  homepage 'https://www.nomadproject.io/'
  source "https://releases.hashicorp.com/#{name}/#{version}/#{name}_#{version}_linux_amd64.zip"
  sha256 'c0479dcc03d35c1b0f6e7be256732431384bec16901a124dd97b2a60d465fb91'

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
