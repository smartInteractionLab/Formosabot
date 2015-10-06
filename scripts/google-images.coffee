# Description:
#   A way to interact with the Google Images API.
#
# Configuration
#   HUBOT_GOOGLE_CSE_KEY - Your Google developer API key
#   HUBOT_GOOGLE_CSE_ID - The ID of your Custom Search Engine
#   HUBOT_MUSTACHIFY_URL - Optional. Allow you to use your own mustachify instance.
#
# Commands:
#   hubot image me <query> - The Original. Queries Google Images for <query> and returns a random top result.
#   hubot animate me <query> - The same thing as `image me`, except adds a few parameters to try to return an animated GIF instead.
#   hubot mustache me <url> - Adds a mustache to the specified URL.
#   hubot mustache me <query> - Searches Google Images for the specified query and mustaches it.

module.exports = (robot) ->
  robot.respond /(image|img)( me)? (.*)/i, (msg) ->
    imageMe msg, msg.match[3], (url) ->
      msg.send url

  robot.respond /animate( me)? (.*)/i, (msg) ->
    animateMe msg, msg.match[2], true, (url) ->
      msg.send url

  robot.respond /(?:mo?u)?sta(?:s|c)h(?:e|ify)?(?: me)? (.*)/i, (msg) ->
    mustacheBaseUrl = process.env.HUBOT_MUSTACHIFY_URL?.replace(/\/$/, '') or "http://mustachify.me"
    mustachify = "#{mustacheBaseUrl}/rand?src="
    imagery = msg.match[1]

    if imagery.match /^https?:\/\//i
      encodedUrl = encodeURIComponent imagery
      msg.send "#{mustachify}#{encodedUrl}"
    else
      imageMe msg, imagery, false, true, (url) ->
        encodedUrl = encodeURIComponent url
        msg.send "#{mustachify}#{encodedUrl}"

imageMe = (msg, query, animated, faces, cb) ->
  # Using deprecated Google image search API
  q = v: '1.0', rsz: '8', q: query, safe: 'active'
  if animated is true
    q.as_filetype = 'gif'
    q.q += ' animated'
  if faces is true
    q.as_filetype = 'jpg'
    q.imgtype = 'face'
  msg.http('https://ajax.googleapis.com/ajax/services/search/images')
    .query(q)
    .get() (err, res, body) ->
      if err
        msg.send "Encountered an error :( #{err}"
        return
      if res.statusCode isnt 200
        msg.send "Bad HTTP response :( #{res.statusCode}"
        return
      images = JSON.parse(body)
      images = images.responseData?.results
      if images?.length > 0
        image = msg.random images
        cb ensureResult(image.unescapedUrl, animated)
      else
        msg.send "Sorry, I found no results for '#{query}'."



# Forces giphy result to use animated version
ensureResult = (url, animated) ->
  if animated is true
    ensureImageExtension url.replace(
      /(giphy\.com\/.*)\/.+_s.gif$/,
      '$1/giphy.gif')
  else
    ensureImageExtension url

# Forces the URL look like an image URL by adding `#.png`
ensureImageExtension = (url) ->
  if /(png|jpe?g|gif)$/i.test(url)
    url
  else
    "#{url}#.png"
