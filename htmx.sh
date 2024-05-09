function clone() {
  # get a dir from 'releases'
  repo="plutoniumm/htmx-templates";
  dir="ts-bun";
  # get latest release
  release=$(curl -s https://api.github.com/repos/$repo/releases/latest | jq -r '.tag_name');
  # download the release
}