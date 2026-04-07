# SonarQube Examples Monorepo

This repository contains self-contained, buildable example projects for every language supported by **SonarQube Server** (Community, Developer, Enterprise editions) and **SonarQube Cloud**.

Each subdirectory (`java/`, `python/`, `go/`, etc.) is a standalone project that:
- Has minimal, compilable/runnable source code in that language
- Includes a `sonar-project.properties` or equivalent SonarQube configuration
- Includes a `.github/workflows/language-sonar.yml` GitHub Actions workflow that runs a SonarQube scan on every push and pull request

## 🚀 Prerequisites

To activate scanning, add `SONAR_TOKEN` as an encrypted secret in your repository:
- Go to **Settings → Secrets and variables → Actions → New repository secret**
- Name: `SONAR_TOKEN`
- Value: your SonarQube Cloud (or Server) user token

The GitHub Actions workflows are pre-configured to use `sonarcloud.io` as the host. For **SonarQube Server**, update `sonar.host.url` in each `sonar-project.properties` and in `.github/workflows/language-sonar.yml`.

## 📁 Directory Structure

| Directory | Language | SonarQube Server Edition | SonarQube Cloud |
|---|---|---|---|
| `abap/` | ABAP | Developer | ✅ |
| `ansible/` | Ansible | Community | ✅ |
| `apex/` | Apex (Salesforce) | Enterprise | ✅ |
| `arm/` | Azure Resource Manager | Community | ✅ |
| `c/` | C | Developer | ✅ |
| `cloudformation/` | AWS CloudFormation | Community | ✅ |
| `cobol/` | COBOL | Developer | ✅ |
| `cpp/` | C++ | Developer | ✅ |
| `csharp/` | C# | Community | ✅ |
| `css/` | CSS / SCSS / Less | Community | ✅ |
| `dart/` | Dart / Flutter | Community | ✅ |
| `dockerfile/` | Docker | Community | ✅ |
| `flex/` | Flex (ActionScript) | Community | ✅ |
| `github-actions/` | GitHub Actions (workflows) | Community | ✅ |
| `go/` | Go | Community | ✅ |
| `groovy/` | Groovy | Community | ✅ |
| `html/` | HTML | Community | ✅ |
| `java/` | Java + JSP | Community | ✅ |
| `javascript/` | JavaScript / React / Vue / Angular | Community | ✅ |
| `json/` | JSON | Community | ✅ |
| `kotlin/` | Kotlin | Community | ✅ |
| `kubernetes/` | Kubernetes / Helm | Community | ✅ |
| `objc/` | Objective-C | Developer | ✅ |
| `php/` | PHP | Community | ✅ |
| `pli/` | PL/I | Developer | ✅ |
| `plsql/` | PL/SQL | Developer | ✅ |
| `python/` | Python | Community | ✅ |
| `rpg/` | RPG | Developer | ✅ |
| `ruby/` | Ruby | Community | ✅ |
| `rust/` | Rust | Community | ✅ |
| `scala/` | Scala | Community | ✅ |
| `shell/` | Shell (Bash/sh/ksh) | Community | ✅ |
| `swift/` | Swift | Developer | ✅ |
| `terraform/` | Terraform (HCL) | Community | ✅ |
| `tsql/` | T-SQL | Developer | ✅ |
| `typescript/` | TypeScript | Community | ✅ |
| `vbnet/` | VB.NET | Community | ✅ |
| `xml/` | XML | Community | ✅ |
| `yaml/` | YAML | Community | ✅ |

## 🔧 Workflow Structure

Each language has:
- **Workflow**: `.github/workflows/language-sonar.yml` — GitHub Actions workflow
- **Source code**: `language/src/` — Example source files
- **Configuration**: `language/sonar-project.properties` — SonarQube settings

### Standard Workflow Features
- Triggers on push to `main` and pull requests
- Uses `SonarSource/sonarcloud-github-action@master`
- Cache SonarQube packages for faster scans
- Build steps with `continue-on-error: true` to not block analysis

## 📊 SonarQube Edition Support

| Edition | Languages |
|---|---|
| **Community** | Java, C#, VB.NET, Python, PHP, Ruby, Go, Kotlin, Scala, JavaScript, TypeScript, HTML, CSS, XML, JSON, YAML, Shell, Flex, Terraform, CloudFormation, Kubernetes, Docker, ARM, Ansible, Dart, GitHub Actions, Groovy, Rust |
| **Developer** | C, C++, Objective-C, Swift, PL/SQL, T-SQL, ABAP, COBOL, PL/I, RPG |
| **Enterprise** | Apex (Salesforce) |

## 🤝 Contributing

This is a monorepo for demonstration purposes. Each language example is self-contained and independent.

## 📝 License

MIT License — freely usable in your own projects.