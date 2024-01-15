<p align="right">
    English Document | <a title="繁體中文文件" href="README.zh-TW.md">繁體中文文件 </a>
</p>

> [!TIP]
> This document has been translated by ChatGPT. If there are any errors, please let us know. Thank you.

# Hexo Docker Compose

This project utilizes Docker Compose to quickly set up a Hexo service and supports deploy functionality.

> [!NOTE]
> this project is inspired by the [spurin/docker-hexo](https://github.com/spurin/docker-hexo) with adjustments made to its features.

## Installation

### GitHub Download
You can directly download this project from [GitHub](https://github.com/hankz1108/hexo-docker-compose).
![image](/docs/images/installation-github-download-1.jpg)

### git clone
Alternatively, you can use `git clone` to obtain the project.
```bash
git clone https://github.com/hankz1108/hexo-docker-compose.git my-hexo
cd my-hexo
```

## Configuration
Copy the `.env.example` file in the root directory and rename it to `.envFill in the required options.
```ini
#============== Required Config ==============#
# Hexo should be mapped to the local host's port
SITE_PORT=
# Time zone (e.g., Asia/Taipei)
TIME_ZONE=

#============ Required For Deploy ============#
# Git username
GIT_USER=
# Git user email
GIT_EMAIL=
# GitHub token (required for publishing to GitHub Pages)
GITHUB_TOKEN=
```

## Startup
Create an empty `app` folder in the root directory or place your existing Hexo directory inside it. The structure should look like this:
```
app
├── _config.yml
├── package.json
├── scaffolds
├── source
|   ├── _drafts
|   └── _posts
└── themes
```

Next, open the terminal and execute `docker compose` to build and start the container.
```bash
docker compose up -d
```

Once started successfully, you can view your Hexo site at `http://localhost:<your_port>`.

> [!TIP]
> If Docker fails to start and you encounter the following error message:
> ```
> /init/init.sh: 9: Syntax error: "fi" unexpected (expecting "then")
> ```
> It may be due to different line endings between Windows and Linux systems. Try changing the line endings of `hexo\init\init.sh` and other text files to LF. Then, delete the `container` and `image` and run `docker compose up -d` again.

## Deploy Configuration
If you want to use `hexo-deployer-git` for website deployment, here is an example configuration for `GitHub Pages`.
```yaml
deploy:
  type: git
  repo:
    github:
    url: https://github.com/username/github_page.github.io.git
    branch: master
    token: $GITHUB_TOKEN
  name: $GIT_USER
  email: $GIT_EMAIL
```

## Custom Startup Scripts
You can create any `*.sh` file under `hexo\init\scripts`. The scripts with `.sh` extension in that folder will be automatically executed before starting the Hexo server, allowing you to run any pre-startup scripts you desire.
