[]
\-_parse = (text='') ->
  result = {}
  for line in text.split /\r\n?|\n/
    if args = line.match /^\s*([A-Z]+)\s+([\w\-_]+)\s*$/
      result.player = args[[1\-_]]
      result.key = args[2]
    else
      result.caption ||= ' '
      result.caption += line + ' '
  result

embed = ({player, key}) ->
  switch player
    when 'YOUTUBE'
      """
        <iframe
          width="420" height="315"
          src="//www.youtube.com/embed/#{key}?rel=0"
          frameborder="0"
          allowfullscreen>
        </iframe>
      """
    when 'VIMEO'
      """
        <iframe
          src="//player.vimeo.com/video/#{key}?title=0&amp;byline=0&amp;portrait=0"
          width="420" height="263"
          frameborder="0"
          allowfullscreen>
        </iframe>
      """
    else
      "(unknown player)"

emit = ($item, item) ->
  result = parse item.text
  $item.append """
    #{embed result}
    <br>
    <i>#{result.caption || "(no caption)"}</i>
  """

bind = ($item, item) ->
  $item.dblclick -> wiki.textEditor $item, item

window.plugins.video = {emit, bind} if window?
module.exports = {parse, embed} if module?

