# Keiyoushi Audit
This repo includes a Github Actions pipeline to build keiyoushi extensions APKs from [source](https://github.com/keiyoushi/extensions-source) and compare it against [distributed APK](https://github.com/keiyoushi/extensions). The pipeline is scheduled to run daily 12AM UTC. 

## Why?
Signature included in APK only guarantees APK distributed is built by the same party, but it doesn't guarantees APK is built with the respective source code. Read up more on [reproducible builds](https://en.wikipedia.org/wiki/Reproducible_builds).

## Status
This Github Action Pipeline status will fail when the binary doesn't match the source code OR the binary is missing from the source code.

[![Diff](https://github.com/zhuoyang/keiyoushi-audit/actions/workflows/build_push.yml/badge.svg)](https://github.com/zhuoyang/keiyoushi-audit/actions/workflows/build_push.yml)