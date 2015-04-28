# Description:
#   Get a random developer or designer excuse
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot developer excuse me - Get a random developer excuse
#   hubot developer excuse - Get a random developer excuse
#   hubot excuse - Get a random developer excuse
#
#   hubot designer excuse me - Get a random designer excuse
#   hubot designer excuse - Get a random designer excuse
#
# Author:
#   ianmurrays, hopkinschris

DESIGNER_EXCUSES = [
  "That won't fit the grid.",
  "That's not in the wireframes.",
  "That's a developer thing.",
  "I didn't mock it up that way.",
  "The developer must have changed it.",
  "Did you try hitting refresh?",
  "No one uses IE anyway.",
  "That's not how I designed it.",
  "That's way too skeuomorphic.",
  "That's way too flat.",
  "Just put a long shadow on it.",
  "It wasn't designed for that kind of content.",
  "Josef Müller-Brockmann.",
  "That must be a server thing.",
  "It only looks bad if it's not on Retina.",
  "Are you looking at it in IE or something?",
  "That's not a recognised design pattern.",
  "It wasn't designed to work with this content.",
  "The users will never notice that.",
  "The users might not notice it, but they'll feel it.",
  "These brand guidelines are shit.",
  "You wouldn't get it, it's a design thing.",
  "Jony wouldn't do it like this.",
  "That's a dark pattern.",
  "I don't think that's very user friendly.",
  "That's not what the research says.",
  "I didn't get a change request for that."
]

SMART_SAYINGS = [
  "But Keynote doesn't work on PC's",
  "The Colorpass is down for service",
  "Do you really need a new printer?",
  "You can find it on Smart Works",
  "@smartdesignworldwide.com",
  "Oh you can't find the cups they're in this cabinet labeled plates",
  "You can't use the microwave without labels...your no Smartie",
  "https://files.slack.com/files-pri/T02JPDKNS-F03M5TZ8S/screen_shot_2015-02-13_at_4.05.16_pm.png",
  "https://files.slack.com/files-pri/T02JPDKNS-F02K9Q59S/img_20140912_094113.jpg",
  "They're working on the heating",
  "They're working on the AC",
  "A printer repair man is on the way",
  "It crashes when I do this...well don't do that",
  "Sounds like you have an intrest in that, you should do a shareout",
  "Its an informal shareout",
  "Powerpoint is the best",
  "IOT",
  "Smart Design Fileshare",
  "Take it to Ron",
  "Teru can figure it out.",
  "Put a Postit on-it",
  "Dot Exercise",
  "Do you know how to pull a Post-it right?",
  "Have you seen our Post-it presentation?",
  "Who took my board",
  "Are the any free boards?",
  "REPLY ALL",
  "CC ALL",
  "OK Lets schedule a meeting.",
  "FRIDGE CLEAN OUT AT 4pm..",
  "Family Tour",
  "Tour by the windows",
  "Good morning todays lunch will be ordered from",
  "Bottinos"
]




module.exports = (robot) ->
  robot.respond /(?:developer excuse|excuse)(?: me)?/i, (msg) ->
    robot.http("http://developerexcuses.com")
      .get() (err, res, body) ->
        matches = body.match /<a [^>]+>(.+)<\/a>/i

        if matches and matches[1]
          msg.send matches[1]

  robot.respond /designer excuse(?: me)?/i, (msg) ->
    msg.send msg.random(DESIGNER_EXCUSES)

  robot.respond /smartdesign quotes(?: me)?/i, (msg) ->
    msg.send msg.random(SMART_SAYINGS)
