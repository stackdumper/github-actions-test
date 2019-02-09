workflow "New workflow" {
  on = "push"
  resolves = ["push"]
}

action "build" {
  uses = "actions/docker/cli@master"
  args = "build -t github-actions-test ."
}

action "login" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "tag" {
  uses = "actions/docker/cli@master"
  needs = ["build"]
  args = "tag github-actions-test stackdumper/github-actions-test:$(echo $GITHUB_REF | grep -o '[^/]*$')-${GITHUB_SHA:0:6}"
}

action "push" {
  uses = "actions/docker/cli@master"
  needs = ["build", "login", "tag"]
  args = "push stackdumper/github-actions-test:$(echo $GITHUB_REF | grep -o '[^/]*$')-${GITHUB_SHA:0:6}"
}
