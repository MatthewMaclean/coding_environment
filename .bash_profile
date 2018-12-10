# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi
export PATH=/usr/local/bin:$PATH
export PATH="$PATH:$HOME/.yarn/bin"
source /usr/local/dev-env/bin/profile
export MAGICK_HOME="/Applications/ImageMagick-7.0.7"
export PATH="$MAGICK_HOME/bin:$PATH"
export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"

# PALANTIR STUFF
export REQUESTS_CA_BUNDLE=/usr/local/etc/openssl/cert.pem
export GOPATH=/Volumes/git/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/opt/go/libexec/bin
