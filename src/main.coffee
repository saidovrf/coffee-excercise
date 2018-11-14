onLoad = ->
  date = document.getElementById 'date'
  text = document.getElementById 'text'
  postsBlock = document.getElementById 'posts'
  count = document.getElementById 'leftSymbolsCount'
  postButton = document.getElementById 'postButton'

  # Getting posts from local storage
  posts = localStorage.getItem 'diary'

  if posts
    posts = JSON.parse posts

  # Showing all posts
  for post in posts
    # Create post wrapper
    wrapper = document.createElement 'div'
    wrapper.className = "uk-card uk-card-secondary uk-card-body uk-card-hover"

    # Fill text field
    textNode = document.createElement 'p'
    textNode.innerHTML = post.text

    # Fill date field
    dateNode = document.createElement 'p'
    dateNode.className = "uk-text-meta uk-margin-remove-top"
    dateNode.innerHTML = post.date

    # Adding text and date fields to wrapper
    wrapper.appendChild textNode
    wrapper.appendChild dateNode

    # Adding wrapper to posts block
    postsBlock.appendChild wrapper

  # Function that are watching for a text
  textChanged = ->
    symbolsLeft = 140 - (text.value.length)
    count.innerText = symbolsLeft + ' symbol(s) left'

    if symbolsLeft < 0
      count.style.color = '#e00808'
      postButton.disabled = true
    else if symbolsLeft == 140
      postButton.disabled = true
    else
      count.style.color = '#666'
      postButton.disabled = false

  # Function for saving diary post
  sendPost = ->
    if validateDate()
      date.style.color = '#666'
      date.style.border = '1px solid #e5e5e5'

      post = {
        text: text.value,
        date: date.value
      }

      storage = localStorage.getItem 'diary'
      if storage
        storage = JSON.parse storage
        storage.push post
      else
        storage = [post]

      localStorage.setItem 'diary', JSON.stringify storage
      date.value = ''
      text.value = ''
    else
      date.style.color = '#e00808'
      date.style.border = '1px solid #e00808'
      alert 'You\'ll need to type date in this format: DD.MM.YYYY'

  # Function for date validation
  validateDate = ->
    value = date.value
    pattern =/^([0-9]{2}).([0-9]{2}).([0-9]{4})$/;

    return pattern.test value


  # Prepare listeners
  text.addEventListener 'keyup', textChanged
  postButton.addEventListener 'click', sendPost

document.addEventListener 'DOMContentLoaded', onLoad