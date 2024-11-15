This folder provides the necessary content to install Drupal on an ubuntu system using Docker.

Note: The implementation of docker supplied with Ubuntu is a bit dated.
Don't install it when installing the OS. Instead, install the latest version
using misc/install-docker.sh script

install-docker.sh : Install docker from the docker apt repository
drupal/    Docker content for installing drupal
joomla/	   Docker content for installing joomla


To start all services:

cd drupal
./startup.sh


# To stop and delete volumes:
docker compose down -v

Github requires tokens for remote push.
They can be generated at https://github.com/settings/tokens

git config --global credential.helper store
~/.git-credentials:
https://user:token@github.com
