<p align="right">
    <a title="English Document" href="README.md">English Document</a> | 繁體中文文件
</p>

# Hexo Docker Compose
這個專案是透過Docker Composer快速架設[Hexo](https://hexo.io/)服務，並且支援發布功能。

> [!NOTE]
> 該專案的靈感來自 [spurin/docker-hexo](https://github.com/spurin/docker-hexo)，並對其功能進行了調整。

## 安裝

### GitHub下載
您可以直接透過[GitHub](https://github.com/hankz1108/hexo-docker-compose)下載本專案  
![image](/docs/images/installation-github-download-1.jpg)

### git clone取得
也可以透過`git clone`取得
```bash
git clone https://github.com/hankz1108/hexo-docker-compose.git my-hexo
cd my-hexo
```

### 配置
複製根目錄中的`.env.example`並重新命名為`.env`，並填寫其中的選項
```ini
#=========== 必須的設定 ==========#
# hexo要對到本地主機的port
SITE_PORT=
# 時區(ex:Asia/Taipei)
TIME_ZONE=

#========= 發布需要的設定 =========#
# git使用者名稱
GIT_USER=
# git使用者email
GIT_EMAIL=
# github token(發佈到github pages需要)
GITHUB_TOKEN=
```

## 啟動
需要在根目錄建立一個空的`app`資料夾，或是將現有的hexo目錄放進來，結構應該是這樣的
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

接下來打開終端機，執行`docker compose`建立&啟動容器
```bash
docker compose up -d
```

啟動成功後就可以在`http://localhost:<your_prot>`看到你的hexo了


> [!TIP]
> 如果docker啟動失敗，且出現以下錯誤訊息：
> ```
> /init/init.sh: 9: Syntax error: "fi" unexpected (expecting "then")
> ```
> 有可能是windows系統與Linux換行符號不同導致的  
> 嘗試將`hexo\init\init.sh`與其他需要在`container`執行的文字檔全部改為LF結尾  
> 再刪除`container`與`image`後重新執行`docker compose up -d`


## 發布設定
如果你要使用`hexo-deployer-git`進行網站發布，以下是`github pages`設定範例。
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

## 自訂啟動腳本

您可以在`hexo\init\scripts`底下建立任意名稱的`*.sh`檔案  
腳本會自動執行該資料夾底下以`.sh`結尾的檔案  
讓您可以在hexo伺服器執行前先執行您想要的腳本

