# Seer Interactive REPL

Run `seer` with no arguments to enter the REPL:

```
$ seer
seer> lookup example.com
seer> dig github.com MX @1.1.1.1
seer> status cloudflare.com
seer> ssl cloudflare.com
seer> compare example.com A @8.8.8.8 @1.1.1.1
seer> subdomains example.com
seer> diff example.com google.com
seer> tld .com
seer> watch add example.com
seer> watch
seer> history example.com
seer> set output json
seer> help
seer> exit
```

## Features

- Tab completion for commands, record types, bulk operations, output formats, and watch actions
- Usage hints (type a command and press space)
- Command history saved to `~/.seer_history`
- Just type a domain name directly to run a smart lookup
- Ctrl+C or Ctrl+D to exit
