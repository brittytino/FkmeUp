# Contributing to FkmeUp

## Setup

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
```

## Branching

- Create a feature branch from `main`
- Keep PRs focused and small
- Include tests for behavioral changes

## Code Standards

- Keep null-safety strict
- Avoid introducing global mutable state
- Preserve local-first + non-blocking sync behavior
- Do not add AI/collaboration/social features

## Pull Request Checklist

- [ ] `flutter analyze` passes
- [ ] tests pass
- [ ] no placeholder/stub logic added
- [ ] README/docs updated when behavior changes

## Commit Guidance

Use descriptive commit messages with functional scope, e.g.:
- `sync: add retry backoff for queue items`
- `tasks: fix duplicate completion handling`
