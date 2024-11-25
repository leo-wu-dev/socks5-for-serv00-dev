#!/bin/bash

USER=$(whoami)
# WORKDIR="/home/${USER}/.nezha-agent"
USER_HOME="/home/${USER}"
# FILE_PATH="/home/${USER}/.s5"
# CRON_S5="nohup ${FILE_PATH}/s5 -c ${FILE_PATH}/config.json >/dev/null 2>&1 &"
# CRON_NEZHA="nohup ${WORKDIR}/start.sh >/dev/null 2>&1 &"
CRON_XUI="${USER_HOME}/monitor-xui.sh"
# PM2_PATH="/home/${USER}/.npm-global/lib/node_modules/pm2/bin/pm2"
# CRON_JOB="*/12 * * * * $PM2_PATH resurrect >> /home/$(whoami)/pm2_resurrect.log 2>&1"
# REBOOT_COMMAND="@reboot pkill -kill -u $(whoami) && $PM2_PATH resurrect >> /home/$(whoami)/pm2_resurrect.log 2>&1"

echo "检查并添加 crontab 任务; 用户：${USER}"

# if [ "$(command -v pm2)" == "/home/${USER}/.npm-global/bin/pm2" ]; then
#   echo "已安装 pm2，并返回正确路径，启用 pm2 保活任务"
#   (crontab -l | grep -F "$REBOOT_COMMAND") || (crontab -l; echo "$REBOOT_COMMAND") | crontab -
#   (crontab -l | grep -F "$CRON_JOB") || (crontab -l; echo "$CRON_JOB") | crontab -
# else
  # if [ -e "${WORKDIR}/start.sh" ] && [ -e "${FILE_PATH}/config.json" ]; then
  #   echo "添加 nezha & socks5 的 crontab 重启任务"
  #   (crontab -l | grep -F "@reboot pkill -kill -u $(whoami) && ${CRON_S5} && ${CRON_NEZHA}") || (crontab -l; echo "@reboot pkill -kill -u $(whoami) && ${CRON_S5} && ${CRON_NEZHA}") | crontab -
  #   (crontab -l | grep -F "* * pgrep -x \"nezha-agent\" > /dev/null || ${CRON_NEZHA}") || (crontab -l; echo "*/12 * * * * pgrep -x \"nezha-agent\" > /dev/null || ${CRON_NEZHA}") | crontab -
  #   (crontab -l | grep -F "* * pgrep -x \"s5\" > /dev/null || ${CRON_S5}") || (crontab -l; echo "*/12 * * * * pgrep -x \"s5\" > /dev/null || ${CRON_S5}") | crontab -
  # el
  # if [ -e "${WORKDIR}/start.sh" ]; then
  #   echo "添加 nezha 的 crontab 重启任务"
  #   (crontab -l | grep -F "@reboot pkill -kill -u $(whoami) && ${CRON_NEZHA}") || (crontab -l; echo "@reboot pkill -kill -u $(whoami) && ${CRON_NEZHA}") | crontab -
  #   (crontab -l | grep -F "* * pgrep -x \"nezha-agent\" > /dev/null || ${CRON_NEZHA}") || (crontab -l; echo "*/12 * * * * pgrep -x \"nezha-agent\" > /dev/null || ${CRON_NEZHA}") | crontab -
  # el
  # if [ -e "${FILE_PATH}/config.json" ]; then
  #   echo "添加 socks5 的 crontab 重启任务"
  #   (crontab -l | grep -F "@reboot pkill -kill -u $(whoami) && ${CRON_S5}") || (crontab -l; echo "@reboot pkill -kill -u $(whoami) && ${CRON_S5}") | crontab -
  #   (crontab -l | grep -F "* * pgrep -x \"s5\" > /dev/null || ${CRON_S5}") || (crontab -l; echo "*/12 * * * * pgrep -x \"s5\" > /dev/null || ${CRON_S5}") | crontab -
  # fi
# fi
  if [ -e "${USER_HOME}/monitor-xui.sh" ]; then
    echo "添加 XUI 的 crontab 保活任务"
    (crontab -l | grep -F "* * pgrep -x \"x-ui\" > /dev/null || ${CRON_XUI}") || (crontab -l; echo "* * * * * pgrep -x \"x-ui\" > /dev/null || ${CRON_XUI}") | crontab -
  else
    echo '#!/bin/bash

# Telegram Bot 信息
BOT_TOKEN="8034345250:AAG4s-bUEggcGUYaVOW2SZdLS0ygloZzmT0"
CHAT_ID="7248991923"

# 进程名称
PROCESS_NAME="x-ui"

# 获取当前系统用户名
USER_NAME=$(whoami)


# 函数：发送 Telegram 通知
send_telegram_notification() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d chat_id="$CHAT_ID" \
        -d text="$message"
}

# 检查进程是否在运行
if ! pgrep -x "$PROCESS_NAME" > /dev/null
then
    echo "$PROCESS_NAME 进程没有运行，正在启动..."
    # 启动 x-ui 进程
   #
    ~/x-ui.sh start &
    
    # 创建通知消息
    MESSAGE="警告: $PROCESS_NAME 进程未运行，已启动。当前系统用户名: $USER_NAME"
    
    # 发送 Telegram 通知
    send_telegram_notification "$MESSAGE"
else
    echo "$PROCESS_NAME 进程正在运行。"
fi' >> monitor-xui.sh
  chmod +x monitor-xui.sh
  (crontab -l | grep -F "* * pgrep -x \"x-ui\" > /dev/null || ${CRON_XUI}") || (crontab -l; echo "* * * * * pgrep -x \"x-ui\" > /dev/null || ${CRON_XUI}") | crontab -
  fi
