# Root101 landing page

The site of [Root101](https://root101.dev): what we are, our open source projects and the people behind them. Built with Flutter web.

## Run it

The Flutter version is pinned with [fvm](https://fvm.app) (`.fvmrc`).

```sh
fvm flutter pub get
fvm flutter run -d chrome
```

## Build

```sh
docker build -t root101-landing .
docker run -p 8080:80 root101-landing
```

The image builds the web release and serves it with nginx (`docker/`). To change the Flutter version, update both `.fvmrc` and `FLUTTER_VERSION` in the `Dockerfile`.

## Where things live

| What                          | Where                                              |
|-------------------------------|----------------------------------------------------|
| Projects (links, previews)    | `lib/features/projects/data/projects_catalog.dart` |
| Team                          | `lib/features/team/data/team_catalog.dart`         |
| Domain, GitHub, contact email | `lib/config/site.dart`                             |
| Texts (en / es)               | `lib/l10n/*.i18n.yaml`, then `fvm dart run slang`  |
| Colors, sizes, shared widgets | `lib/design_system/`                               |

## Tests

```sh
fvm flutter test
```

## Releases

See [CHANGELOG.md](CHANGELOG.md). Pending work is in [ROADMAP.md](ROADMAP.md).

## License

[LICENSE.md](LICENSE.md)
