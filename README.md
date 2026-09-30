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
Codespaces forwarded hostname when available and localhost otherwise. Legacy Pelican-format post metadata is handled by the Hugo templates, and posts
use their filenames for individual `/posts/` URLs. The menu includes a
reverse-chronological `/archives/` page, and `/tags/` groups posts by their
legacy metadata tags. Pelican image and internal-post-link placeholders are
translated during rendering. To build without Docker, install Hugo Extended
0.165.0 and run
`hugo --gc --minify --environment production`.

## Configuration notes

`hugo.toml` maps the old Pelican settings to Hugo. Small project-level
templates adapt the legacy metadata format and provide the archives and tags
pages; PaperMod remains a pinned submodule:

| Hugo setting | Pelican setting or reason |
| --- | --- |
| `baseURL`, `title`, `locale`, `timeZone`, `params.author` | Retain the published domain, site name, English content, London timezone, and author. The production base URL replaces the development/publish split in `pelicanconf.py` and `publishconf.py`. |
| `theme = "PaperMod"` and submodule pin | Use the stock PaperMod v8.0 theme at a fixed commit so theme updates are explicit and reversible. |
| `mainSections`, `pagination.pagerSize` | Show posts on the home page and retain Pelican's ten-post page size. |
| `permalinks.posts` | Keep individual `/posts/{filename}` article paths. |
| `permalinks.term`, `taxonomies` | Retain tag, category, and author paths. Legacy tags are rendered from post metadata on the generated tags index. |
| `rssLimit` | Keep the production feed limit of ten entries. Hugo's stock output is RSS at its standard URL, rather than Pelican's Atom file at `feeds/all.atom.xml`. |
| `params.homeInfoParams` | Carry over the blog banner's title and subtitle as PaperMod's home introduction; the theme's custom Bootstrap styling is intentionally not recreated. |
| `params.socialIcons`, `params.images`, `params.env` | Preserve the GitHub profile link and Open Graph/Twitter card metadata, including the configured site-wide social image. PaperMod generates these metadata tags without theme changes. |
| `params.DateFormat` | Keep the existing year-month-day date display. |
| `markup.goldmark.renderer.unsafe` | Allow migrated posts' existing inline HTML to render. Only use trusted blog content with this enabled. |
| `markup.highlight` | Keep Pelican's Monokai code highlighting through Hugo's built-in highlighter. |
| `module.mounts` | Restore Hugo's default project mounts, expose `content/images` at `/images/`, map the legacy About page to `/about/`, and mount this repository's archive page independently of the external content checkout. |
| `enableRobotsTXT` | Have Hugo generate the crawler guidance file for the published site. |

The PaperMod submodule remains pinned and unmodified. Project-level layouts
adapt Pelican metadata, admonitions, tags, image paths, and internal post links;
add the legacy About route, a styled 404 page, labeled dates, and a credit-free
footer; and replace the theme's deprecated language-property references. The
extended stylesheet restores image positioning and paragraph spacing, aligns
lists, styles blockquotes, removes post-card movement, and reduces the home
banner's excess height.
