# blog-config

Hugo configuration for stevenmaude.co.uk. The blog posts and images remain in
the separate [blog-content repository](https://github.com/StevenMaude/blog-content);
they are not committed here.

## Build and preview

The Hugo theme is pinned as a submodule. Initialize it and check out the
separate content repository before building:

```sh
git submodule update --init --recursive
git clone --recurse-submodules https://github.com/StevenMaude/blog-content.git content
```

Build and run the Hugo preview server in a container:

```sh
docker build -t stevenmaude-blog .
docker run --rm -p 1313:1313 stevenmaude-blog
```

The container runs Hugo's built-in preview server from the official Hugo
Extended 0.165.0 image at `ghcr.io/gohugoio/hugo`; no nginx is needed to preview
the site. Open <http://localhost:1313>. This server is intended for development
and preview, not production hosting. For production, build the static site with
`hugo --gc --minify --environment production` and deploy the generated `public/`
directory to a static host. The dev container uses the same pinned Hugo version;
run `./devserver.sh` there and open the forwarded port 1313. The script uses the
Codespaces forwarded hostname when available and localhost otherwise. The site
uses PaperMod's stock templates and styles. The separate `blog-content`
repository is in Pelican format; this configuration does not convert its
metadata or Pelican-specific markup to Hugo front matter or shortcodes. To build
without Docker, install Hugo Extended 0.165.0 and run
`hugo --gc --minify --environment production`.

## Configuration notes

`hugo.toml` configures the site and PaperMod remains a pinned submodule:

| Hugo setting | Pelican setting or reason |
| --- | --- |
| `baseURL`, `title`, `languageCode`, `timeZone`, `params.author` | Retain the published domain, site name, English content, London timezone, and author. The production base URL replaces the development/publish split in `pelicanconf.py` and `publishconf.py`. |
| `theme = "PaperMod"` and submodule pin | Use the stock PaperMod v8.0 theme at a fixed commit so theme updates are explicit and reversible. |
| `mainSections`, `pagination.pagerSize` | Show posts on the home page and retain Hugo's ten-post page size. |
| `params.images`, `params.env` | Preserve the configured site-wide Open Graph/Twitter image and production environment metadata. |
| `params.DateFormat` | Keep the existing year-month-day date display. |
| `module.mounts` | Restore Hugo's default project mounts and expose `content/images` at `/images/`. |
| `enableRobotsTXT` | Have Hugo generate the crawler guidance file for the published site. |

The PaperMod submodule remains pinned and unmodified. There are no project-level
layout or stylesheet overrides; rendering and presentation are provided by
stock PaperMod.
