# 出力先のログファイルの指定
set :output, 'log/crontab.log'
# ジョブの実行環境の指定
set :environment, :production
env :SHELL, "/bin/bash"
env :PATH, "/home/rails/.rbenv/shims/:/bin:/usr/bin:/sbin:/usr/sbin:$PATH"
# 毎日朝7時30分にrakeタスクを実行
# every 1.minutes do
#   rake "twitter:tweet"
# end

every 1.day, :at => '7:30 am' do
  rake "twitter:tweet"
end

#時刻を変更したら下記のコマンドで設定して確認する
#RAILS_ENV=production bundle exec whenever --update-crontab
#crontab -l
