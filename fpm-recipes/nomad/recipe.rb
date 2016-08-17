class Nomad < FPM::Cookery::Recipe
  name 'nomad'

  version '0.4.1'
  revision '1'
  description 'A Distributed, Highly Available, Datacenter-Aware Scheduler'

  homepage 'https://www.nomadproject.io/'
  source "https://releases.hashicorp.com/#{name}/#{version}/#{name}_#{version}_linux_amd64.zip"
  sha256 '0cdb5dd95c918c6237dddeafe2e9d2049558fea79ed43eacdfcd247d5b093d67'

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
