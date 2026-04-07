# SonarQube Examples Monorepo

This repository contains self-contained, buildable example projects for every language supported by **SonarQube Server** (Community, Developer, Enterprise editions) and **SonarQube Cloud**.

Each subdirectory (`java/`, `python/`, `go/`, etc.) is a standalone project that:
- Has minimal, compilable/runnable source code in that language
- Includes a `sonar-project.properties` or equivalent SonarQube configuration
- Includes a `.github/workflows/sonar.yml` GitHub Actions workflow that runs a SonarQube scan on every push and pull request

## 🚨 Prerequisites

To activate scanning, add `SONAR_TOKEN` as an encrypted secret in your repository:
- Go to **Settings → Secrets and variables → Actions → New repository secret**
- Name: `SONAR_TOKEN`
- Value: your SonarQube Cloud (or Server) user token

The GitHub Actions workflows are pre-configured to use `sonarcloud.io` as the host. For **SonarQube Server**, update `sonar.host.url` in each `sonar-project.properties` and in `.github/workflows/sonar.yml`.

## 📂 Directory Structure

| Directory | Language | SonarQube Server Edition | SonarQube Cloud |
|---|---|---|---|
| `java/` | Java + JSP | Community | ✅ |
| `csharp/` | C# | Community | ✅ |
| `vbnet/` | VB.NET | Community | ✅ |
| `python/` | Python | Community | ✅ |
| `php/` | PHP | Community | ✅ |
| `ruby/` | Ruby | Community | ✅ |
| `go/` | Go | Community | ✅ |
| `kotlin/` | Kotlin | Community | ✅ |
| `scala/` | Scala | Community | ✅ |
| `javascript/` | JavaScript / React / Vue / Angular | Community | ✅ |
| `typescript/` | TypeScript | Community | ✅ |
| `html/` | HTML | Community | ✅ |
| `css/` | CSS / SCSS / Less | Community | ✅ |
| `xml/` | XML | Community | ✅ |
| `json/` | JSON | Community | ✅ |
| `yaml/` | YAML | Community | ✅ |
| `shell/` | Shell (Bash/sh/ksh) | Community | ✅ |
| `flex/` | Flex (ActionScript) | Community | ✅ |
| `terraform/` | Terraform (HCL) | Community | ✅ |
| `cloudformation/` | AWS CloudFormation | Community | ✅ |
| `kubernetes/` | Kubernetes / Helm | Community | ✅ |
| `dockerfile/` | Docker | Community | ✅ |
| `arm/` | Azure Resource Manager | Community | ✅ |
| `c/` | C | Developer | ✅ |
| `cpp/` | C++ | Developer | ✅ |
| `objc/` | Objective-C | Developer | ✅ |
| `swift/` | Swift | Developer | ✅ |
| `plsql/` | PL/SQL | Developer | ✅ |
| `tsql/` | T-SQL | Developer | ✅ |
| `abap/` | ABAP | Developer | ✅ |
| `apex/` | Apex (Salesforce) | Enterprise | ✅ |
| `ansible/` | Ansible | Community | ✅ |
| `dart/` | Dart / Flutter | Community | ✅ |
| `github-actions/` | GitHub Actions (workflows) | Community | ✅ |

## 🔧 License

MIT License — freely usable in your own projects.
