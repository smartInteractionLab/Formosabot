# Description:
#   Tracking Dan Formosa around the world
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot where is dan - Ask the Formosabot Where dan is
#
# Author:
#   ryanatwork

asiancity = [
  "Tokyo,Japan",
  "Seoul,South Korea",
  "Shanghai,China",
  "Manila,Philippines",
  "Beijing,China",
  "Osaka,Japan",
  "Guangzhou,China",
  "Shenzhen,China",
  "Bangkok,Thailand",
  "Nagoya,Japan",
  "Hong Kong",
  "Wuhan,China",
  "Taipei,Taiwan",
  "Tianjin,China",
  "Chongqing,China",
  "Ho Chi Minh City,Vietnam",
  "Shenyang,China",
  "Singapore",
  "China",
  "Asia",
  "Maybe NY...",
]

module.exports = (robot) ->
  robot.respond /(where is dan)/i, (msg) ->
    msg.reply msg.random asiancity
