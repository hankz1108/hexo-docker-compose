# Build a base server and configuration if it doesnt exist, then start
if [ "$(ls -A /app)" ]; then
    echo "***** App directory exists and has content, continuing *****";
else
    echo "***** App directory is empty, initialising with hexo and hexo-admin *****"
    hexo init
    npm install
    npm install --save hexo-admin;
fi;
if [ ! -f /app/requirements.txt ]; then
    echo "***** App directory contains no requirements.txt file, continuing *****";
else
    echo "***** App directory contains a requirements.txt file, installing npm requirements *****";
    cat /app/requirements.txt | xargs npm --prefer-offline install --save;
fi;
if [ "$(ls -A /app/.ssh 2>/dev/null)" ]; then
    echo "***** App .ssh directory exists and has content, continuing *****";
else
    echo "***** App .ssh directory is empty, initialising ssh key and configuring known_hosts for common git repositories (github/gitlab) *****"
    rm -rf ~/.ssh/*
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P ""
    ssh-keyscan github.com > ~/.ssh/known_hosts 2>/dev/null
    ssh-keyscan gitlab.com >> ~/.ssh/known_hosts 2>/dev/null
    cp -r ~/.ssh /app;
fi;
echo "***** Running git config, user = ${GIT_USER}, email = ${GIT_EMAIL} *****"

git config --global user.email ${GIT_EMAIL}
git config --global user.name ${GIT_USER}
echo "***** Copying .ssh from App directory and setting permissions *****"
cp -r /app/.ssh ~/
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa.pub
chmod 700 ~/.ssh
echo "***** Contents of public ssh key (for deploy) - *****"
cat ~/.ssh/id_rsa.pub

echo "***** set time zone *****"
ln -snf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime
echo ${TIME_ZONE} > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

echo "***** run init shell *****"
if [ "$(ls -A /app/Hexo/init/scripts/*.sh 2>/dev/null)" ]; then
    for shell in /app/Hexo/init/scripts/*.sh; do
        sh "$shell"
    done
fi

echo "***** Starting server on port ${HEXO_SERVER_PORT} *****"
hexo server -d -p ${HEXO_SERVER_PORT}
