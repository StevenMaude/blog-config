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

Build and run the production image:

```sh
docker build -t stevenmaude-blog .
docker run --rm -p 8080:80 stevenmaude-blog
```

The image builds with Hugo Extended 0.165.0 and serves the generated site with
nginx 1.29.1. The dev container uses the same pinned Hugo version. In the
dev container, run `hugo server --bind 0.0.0.0` and open the forwarded port
1313. To build without Docker, install Hugo Extended 0.165.0 and run
`hugo --gc --minify --environment production`.

## Configuration notes

`hugo.toml` maps the old Pelican settings to Hugo while leaving PaperMod
unmodified:

| Hugo setting | Pelican setting or reason |
| --- | --- |
| `baseURL`, `title`, `languageCode`, `timeZone`, `params.author` | Retain the published domain, site name, English content, London timezone, and author. The production base URL replaces the development/publish split in `pelicanconf.py` and `publishconf.py`. |
| `theme = "PaperMod"` and submodule pin | Use the stock PaperMod v8.0 theme at a fixed commit so theme updates are explicit and reversible. |
| `mainSections`, `pagination.pagerSize` | Show posts on the home page and retain Pelican's ten-post page size. |
| `permalinks.posts` | Keep the Pelican `/posts/{slug}` article path, using Hugo's directory-style URLs. Migrated post front matter should keep aliases for older `.html` URLs. |
| `permalinks.term`, `taxonomies` | Retain tag, category, and author archives, using the old singular `/tag/`, `/category/`, and `/author/` paths for term pages. |
| `rssLimit` | Keep the production feed limit of ten entries. Hugo's stock output is RSS at its standard URL, rather than Pelican's Atom file at `feeds/all.atom.xml`. |
| `params.homeInfoParams` | Carry over the blog banner's title and subtitle as PaperMod's home introduction; the theme's banner layout and custom Bootstrap styling are intentionally not recreated. |
| `params.socialIcons`, `params.images`, `params.env` | Preserve the GitHub profile link and Open Graph/Twitter card metadata, including the configured site-wide social image. PaperMod generates these metadata tags without theme changes. |
| `params.DateFormat` | Keep the existing year-month-day date display. |
| `markup.goldmark.renderer.unsafe` | Allow migrated posts' existing inline HTML to render. Only use trusted blog content with this enabled. |
| `markup.highlight` | Keep Pelican's Monokai code highlighting through Hugo's built-in highlighter. |
| `module.mounts` | Restore Hugo's default project mounts and expose `content/images` at `/images/`, matching Pelican's static image paths. |
| `enableRobotsTXT` | Have Hugo generate the crawler guidance file for the published site. |

PaperMod is used as-is: Pelican-specific options such as the Bootstrap theme,
sidebar tag cloud, custom CSS, and Atom feed filename have no equivalent in the
stock theme/configuration and are not implemented as theme overrides.
