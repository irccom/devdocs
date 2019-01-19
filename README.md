# IRC Foundation Developer Docs
This set of documentation is hosted by the IRC Foundation, describing the IRC (Internet Relay Chat) protocol in detail. The docs here are written to give developers a good footing when writing software that uses or interacts with IRC.

This documentation takes on a lot of structure from something like the [MDN Web Docs](https://developer.mozilla.org/en-US/), which documents web technology instead.


## Building
Primarily, these docs are meant to be plugged into the proper IRC Foundation website. However, when developing that's irritating to do so instead we support building the site in two different modes – `dev` and `prod`.

In `dev` mode, the site will build a basic browsable version that can be viewed through the server that Jekyll sets up. In `prod` mode, what's output is instead the HTML and files that get plugged into the Foundation site.

**dev**
```sh
bundle exec jekyll serve -w --config _config-dev.yml
```

**prod**
```sh
bundle exec jekyll b --config _config-prod.yml
```


## Documentation Structure
Here's the rough breakdown of what's included here:

- Tech References
    - Command Reference
    - Numeric Reference
    - Glossary
- Guides


### Future
Some stuff I want to describe very explicitly in future include:

- Hostname masking/cloaking
- Virtual Hosts
- `refs/modes/c/invite-only` and etc, `modes/c` for chan and `modes/u` for user modes, check the `join` command ref for links
- `refs/isupport/chanlimit` and etc


## Other References
Here are some other IRC references that devs may find useful:

- [IRCv3 Working Group](https://ircv3.net/)
- [ircdocs](http://ircdocs.horse/)
