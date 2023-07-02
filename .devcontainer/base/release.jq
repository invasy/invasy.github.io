#!/usr/bin/env -S jq -rf
.tag_name as $tag |
.assets | map(select(.name | test($pattern; "x"))) | .[0] |
if . then "[tag]='" + $tag + "'
[url]='" + .browser_download_url + "'
[filename]='" + .name + "'" else "" end
