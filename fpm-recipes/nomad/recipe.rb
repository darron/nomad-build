class Nomad < FPM::Cookery::Recipe
  name 'nomad'

  version '0.2.0'
  revision '1'
  description 'A Distributed, Highly Available, Datacenter-Aware Scheduler'

  homepage 'https://www.nomadproject.io/'
  source "https://releases.hashicorp.com/#{name}/#{version}/#{name}_#{version}_linux_amd64.zip"
  sha256 'f4525cbd99fd57ef607f9556be4f4bc39f82391947f40cc993538bba7da5bf90'

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
