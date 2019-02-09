workflow "New workflow" {
  on = "push"
  resolves = ["push", "push_latest"]
}

action "build" {
  uses = "actions/docker/cli@master"
  args = "build -t github-actions-test ."
}

action "login" {
  uses = "actions/docker/login@master"
  needs = ["build"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "tag" {
  uses = "actions/docker/cli@master"
  needs = ["login"]
  args = "tag github-actions-test stackdumper/github-actions-test:$(echo $GITHUB_REF | grep -o '[^/]*$')-${GITHUB_SHA:0:6}"
}

action "push" {
  uses = "actions/docker/cli@master"
  needs = ["tag"]
  args = "push stackdumper/github-actions-test:$(echo $GITHUB_REF | grep -o '[^/]*$')-${GITHUB_SHA:0:6}"
}

action "tag_latest" {
  uses = "actions/docker/cli@master"
  needs = ["login"]
  args = "tag github-actions-test stackdumper/github-actions-test:latest"
}

action "push_latest" {
  uses = "actions/docker/cli@master"
  needs = ["tag_latest"]
  args = "push stackdumper/github-actions-test:latest"
}


