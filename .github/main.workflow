workflow "Check on Push" {
  on = "push"
  resolves = [
    "Check Formatting",
    "Run Tests",
  ]
}

action "Get Deps" {
  uses = "jclem/action-mix/deps.get@v1.3.2"
  args = "deps.get"
}

action "Run Tests" {
  uses = "jclem/action-mix@v1.3.2"
  args = "coveralls.post --trace -n \"github-actions\" -b \"$GITHUB_REF\" -s \"$GITHUB_SHA\" -c \"$GITHUB_ACTOR\""
  env = {
    MIX_ENV = "test"
  }
  secrets = ["COVERALLS_REPO_TOKEN"]
  needs = ["Get Deps"]
}

action "Check Formatting" {
  uses = "jclem/action-mix@v1.3.2"
  args = "format --check-formatted"
}
