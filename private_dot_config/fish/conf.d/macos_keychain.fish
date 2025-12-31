if status --is-login && test (fastfetch -j | jq -r '.[] | select(.type == "OS") | .result.id') = 'macos'
  eval security unlock-keychain -p REPLACE_ME login.keychain
end
