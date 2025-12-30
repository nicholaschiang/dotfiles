set os (fastfetch -j | jq -r '.[] | select(.type == "OS") | .result.id')
set password REPLACE_ME

if status --is-login && test $os = 'macos'
  eval security unlock-keychain -p $password login.keychain
end
