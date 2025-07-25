#!/usr/bin/env bash

set -euo pipefail

TOOL_NAME="redmine"
TOOL_TEST="redmine --version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if redmine is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//'
}

list_all_versions() {
  list_github_tags
}

get_platform() {
  local platform=""
  case "$OSTYPE" in
    darwin*) platform="osx" ;;
    linux*) platform="linux" ;;
    msys*|cygwin*) platform="win" ;;
    *) fail "Unsupported platform: $OSTYPE" ;;
  esac
  echo "$platform"
}

get_arch() {
  local arch=""
  case "$(uname -m)" in
    x86_64|amd64) arch="x64" ;;
    aarch64|arm64) arch="arm64" ;;
    *) fail "Unsupported architecture: $(uname -m)" ;;
  esac
  echo "$arch"
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  local platform arch
  platform="$(get_platform)"
  arch="$(get_arch)"

  # Construct the download URL based on the release pattern
  url="$GH_REPO/releases/download/v${version}/redmine-cli-${platform}-${arch}.zip"

  echo "* Downloading $TOOL_NAME release $version from $url..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path/bin"
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path/bin/"

    # Make the binary executable
    chmod +x "$install_path/bin/redmine"

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}