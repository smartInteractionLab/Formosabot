# Description:
#   I'm going to get you, sucka
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   git - hubot says 'ima git you sucka'
#
# Author:
#   samn

module.exports = (robot) ->
  regex = /git/i

  robot.hear regex, (msg) ->
     msg.reply 'ima git you sucka'
