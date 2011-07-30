Overview
========

This is a simple project that helps setting up a single server for use with Chef/Soloist so that it can be managed in a traditional system administration fashion.  This approach entails running everything as root, and using a single system RVM installation.

`Capfile` defines tasks to bootstrap the server, sync the Chef root dir, and run soloist.  
`bootstrap.sh` is the script run on the server upon bootstrap.

Invoke like:

    cap [bootstrap|deploy|sync|soloist] HOSTS=<hostname>[:<port>]

(`HOSTS` should only contain a single hostname)

As a convenience the Opscode skeleton Chef repository is checked out under this project so you can fork this project and get started quickly.  Alternatively you can simply change the `local_chef_dir` setting in the `Capfile` to use an independent Chef repository.

See [soloist](https://github.com/mkocher/soloist) for Soloist documentation.

This project was adapted from [chef_deploy](https://github.com/mkocher/chef_deploy).
