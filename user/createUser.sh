adduser zsolt \
&& usermod -aG sudo zsolt \
&& rsync --archive --chown=zsolt:zsolt ~/.ssh /home/zsolt
