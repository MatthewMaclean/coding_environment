# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi
export PATH=/usr/local/bin:$PATH
export PATH="$PATH:$HOME/.yarn/bin"
source /usr/local/dev-env/bin/profile


# PALANTIR STUFF
export REQUESTS_CA_BUNDLE=/usr/local/etc/openssl/cert.pem
