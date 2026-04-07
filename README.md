# SonarQube Examples Monorepo

This repository contains self-contained, buildable example projects for **every language supported by SonarQube Server and SonarQube Cloud**.

Each subdirectory is a standalone project that:
- Has minimal, compilable/runnable source code in that language
- Includes a `sonar-project.properties` for SonarQube configuration
- Includes a `.github/workflows/language-sonar.yml` GitHub Actions workflow that runs a SonarQube scan on every push and pull request

## 🚀 Prerequisites

To activate scanning, add `SONAR_TOKEN` as an encrypted secret in your repository:
- Go to **Settings → Secrets and variables → Actions → New repository secret**
- Name: `SONAR_TOKEN`
- Value: your SonarQube Cloud (or Server) user token

The GitHub Actions workflows are pre-configured to use `sonarcloud.io` as the host. For **SonarQube Server**, update `sonar.host.url` in each `sonar-project.properties` and in `.github/workflows/language-sonar.yml`.

## 📁 Directory Structure

| Directory | Language | SonarQube Cloud | SonarQube Server |
|---|---|---|---|
| `abap/` | ABAP | Enterprise | Enterprise |
| `ansible/` | Ansible | ✅ | ✅ |
| `apex/` | Apex (Salesforce) | Enterprise | Enterprise |
| `arm/` | Azure Resource Manager | ✅ | ✅ |
| `c/` | C | ✅ | ✅ |
| `cloudformation/` | AWS CloudFormation | ✅ | ✅ |
| `cobol/` | COBOL | Enterprise | Enterprise |
| `cpp/` | C++ | ✅ | ✅ |
| `csharp/` | C# | ✅ | ✅ |
| `css/` | CSS | ✅ | ✅ |
| `dart/` | Dart / Flutter | ✅ | ✅ |
| `dockerfile/` | Docker | ✅ | ✅ |
| `flex/` | Flex (ActionScript) | ✅ | ✅ |
| `github-actions/` | GitHub Actions | ✅ | ✅ |
| `go/` | Go | ✅ | ✅ |
| `groovy/` | Groovy | ✅ | ✅ |
| `html/` | HTML | ✅ | ✅ |
| `java/` | Java + JSP | ✅ | ✅ |
| `javascript/` | JavaScript / React / Vue / Angular | ✅ | ✅ |
| `jcl/` | JCL (Job Control Language) | Enterprise | Enterprise |
| `json/` | JSON | ✅ | ✅ |
| `kotlin/` | Kotlin | ✅ | ✅ |
| `kubernetes/` | Kubernetes / Helm | ✅ | ✅ |
| `objc/` | Objective-C | ✅ | ✅ |
| `php/` | PHP | ✅ | ✅ |
| `pli/` | PL/I | Enterprise | Enterprise |
| `plsql/` | PL/SQL | ✅ | ✅ |
| `python/` | Python | ✅ | ✅ |
| `rpg/` | RPG | Enterprise | Enterprise |
| `ruby/` | Ruby | ✅ | ✅ |
| `rust/` | Rust | ✅ | ✅ |
| `scala/` | Scala | ✅ | ✅ |
| `shell/` | Shell (Bash/sh/ksh) | ✅ | ✅ |
| `swift/` | Swift | ✅ | ✅ |
| `terraform/` | Terraform (HCL) | ✅ | ✅ |
| `tsql/` | T-SQL | ✅ | ✅ |
| `typescript/` | TypeScript | ✅ | ✅ |
| `vb6/` | VB6 (Visual Basic 6) | Enterprise | Enterprise |
| `vbnet/` | VB.NET | — | Enterprise |
| `xml/` | XML | ✅ | ✅ |
| `yaml/` | YAML | ✅ | ✅ |

**Total: 40 languages** — complete coverage of all SonarQube-supported languages!

## 🔧 Workflow Structure

Each language has:
- **Workflow**: `.github/workflows/language-sonar.yml` — GitHub Actions workflow
- **Source code**: `language/src/` — Example source files
- **Configuration**: `language/sonar-project.properties` — SonarQube settings

### Standard Workflow Features
- Triggers on push to `main` and pull requests (`opened`, `synchronize`, `reopened`)
- Uses `SonarSource/sonarcloud-github-action@master`
- Build steps with `continue-on-error: true` to not block analysis

## 📊 SonarQube Edition Support

| Edition | Languages |
|---|---|
| **Community/Cloud (Universal)** | Ansible, ARM, C, C++, CloudFormation, C#, CSS, Dart, Docker, Flex, GitHub Actions, Go, Groovy, HTML, Java, JavaScript, JSON, Kotlin, Kubernetes, Objective-C, PHP, PL/SQL, Python, Ruby, Rust, Scala, Shell, Swift, Terraform, TypeScript, TSQL |
| **Enterprise (Server)** | ABAP, Apex, COBOL, JCL, PL/I, RPG, VB.NET |

## 🤝 Contributing

This is a monorepo for demonstration purposes. Each language example is self-contained and independent.

## 📝 License

MIT License — freely usable in your own projects.