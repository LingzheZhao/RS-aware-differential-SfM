find . -name "*.tar.gz" -exec sh -c 'tar xvzf {} -C $(dirname {})' \;
