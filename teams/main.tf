resource "github_team" "all" {
  name        = "all"
  description = "Everyone"
  privacy     = "closed"
}

resource "github_team" "bots" {
  name    = "bots"
  privacy = "secret"
}

resource "github_team" "devops" {
  name           = "devops"
  privacy        = "closed"
  parent_team_id = github_team.all.id
}

resource "github_team" "web" {
  name           = "web"
  privacy        = "closed"
  parent_team_id = github_team.all.id
}

resource "github_team" "mobile" {
  name           = "mobile"
  privacy        = "closed"
  parent_team_id = github_team.all.id
}

output "teams" {
  value = {
    all    = github_team.all.id
    bots   = github_team.bots.id
    devops = github_team.devops.id
    web    = github_team.web.id
    mobile = github_team.mobile.id
  }
}
