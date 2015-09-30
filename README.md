nomad Build
============

This repository automatically builds nomad packages and pushes them to my [Packagecloud Repository](https://packagecloud.io/darron/nomad).

To use the repository - take a look [here](https://packagecloud.io/darron/nomad/install) or:

`curl https://packagecloud.io/install/repositories/darron/nomad/script.deb | sudo bash`

NOTE: This package installs a single self-elected Nomad server. If you're using this in production, please update the `server.hcl` configuration file.

It is controlled with Upstart:

```
service nomad start
service nomad stop
```
